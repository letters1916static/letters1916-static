const indexName = "letters1916-static";

// const apiKey = "0drlT8CHD6T9z8QxQjYXvSWT2dZ75nPv"; /* change this */
const apiKey = "xyz";

const typesenseInstantsearchAdapter = new TypesenseInstantSearchAdapter({
  server: {
    apiKey: apiKey,
    /*     nodes: [
      {
        host: "typesense.acdh-dev.oeaw.ac.at",
        port: "443",
        protocol: "https",
      },
    ], */
    nodes: [
      {
        host: "localhost",
        port: "8108",
        protocol: "http",
      },
    ],
    cacheSearchResultsForSeconds: 2 * 60,
  },
  additionalSearchParameters: {
    query_by: "full_text",
    sort_by: "rec_id:asc",
  },
});

const DEFAULT_CSS_CLASSES = {
  searchableInput: "form-control form-control-sm m-2 border-light-2",
  searchableSubmit: "d-none",
  searchableReset: "d-none",
  showMore: "btn btn-secondary btn-sm align-content-center",
  list: "list-unstyled",
  count: "badge m-2 badge-secondary",
  label: "d-flex align-items-center text-capitalize",
  checkbox: "m-2",
};

const searchClient = typesenseInstantsearchAdapter.searchClient;
const search = instantsearch({
  indexName: indexName,
  searchClient,
});

search.addWidgets([
  instantsearch.widgets.searchBox({
    container: "#searchbox",
    autofocus: true,
    cssClasses: {
      form: "form-inline",
      input: "form-control col-md-11",
      submit: "btn",
      reset: "btn",
    },
  }),

  instantsearch.widgets.hits({
    container: "#hits",
    cssClasses: {
      item: "w-100",
    },
    templates: {
      empty: "Keine Resultate für <q>{{ query }}</q>",
      item(hit, { html, components }) {
        return html` <div>
          <div class="fs-3">
            <a href="${hit.rec_id}.html" class="custom-link">${hit.title}</a>
          </div>
          <p>
            ${hit._snippetResult.full_text.matchedWords.length > 0
              ? components.Snippet({ hit, attribute: "full_text" })
              : ""}
          </p>
          ${hit.place_entities.map(
            (item) =>
              html`<a href="${item.id}.html" class="pe-2 custom-link"
                ><i class="bi bi-geo-alt pe-1"></i>${item.label}</a
              >`,
          )}
          <br />
          ${hit.person_entities.map(
            (item) =>
              html`<a href="${item.id}.html" class="pe-2 custom-link"
                ><i class="bi bi-person pe-1"></i>${item.label}</a
              >`,
          )}
          <!--
          <br />
          ${hit.bibl_entities.map(
            (item) =>
              html`<a href="${item.id}.html" class="pe-2 custom-link"
                ><i class="bi bi-book pe-1"></i>${item.label}</a
              >`,
          )}
          -->
          <br />
        </div>`;
      },
    },
  }),

  instantsearch.widgets.sortBy({
    container: "#sort-by",
    items: [
      { label: "Default", value: `${indexName}` },
      { label: "ID (Ascending)", value: `${indexName}/sort/rec_id:asc` },
      { label: "ID (Descending)", value: `${indexName}/sort/rec_id:desc` },
    ],
  }),

  instantsearch.widgets.stats({
    container: "#stats-container",
    templates: {
      text: `
          {{#areHitsSorted}}
            {{#hasNoSortedResults}}Keine Treffer{{/hasNoSortedResults}}
            {{#hasOneSortedResults}}1 Treffer{{/hasOneSortedResults}}
            {{#hasManySortedResults}}{{#helpers.formatNumber}}{{nbSortedHits}}{{/helpers.formatNumber}} Treffer {{/hasManySortedResults}}
            aus {{#helpers.formatNumber}}{{nbHits}}{{/helpers.formatNumber}}
          {{/areHitsSorted}}
          {{^areHitsSorted}}
            {{#hasNoResults}}No results{{/hasNoResults}}
            {{#hasOneResult}}1 result{{/hasOneResult}}
            {{#hasManyResults}}{{#helpers.formatNumber}}{{nbHits}}{{/helpers.formatNumber}} results{{/hasManyResults}}
          {{/areHitsSorted}}
          found in {{processingTimeMS}}ms
        `,
    },
  }),

  instantsearch.widgets.panel({
    collapsed: ({ state }) => {
      return state.query.length === 0;
    },
    templates: {
      header: "People",
    },
  })(instantsearch.widgets.refinementList)({
    container: "#rf-persons",
    attribute: "person_entities.label",
    searchable: true,
    showMore: true,
    showMoreLimit: 50,
    limit: 10,
    searchablePlaceholder: "Search for people",
    cssClasses: DEFAULT_CSS_CLASSES,
  }),

  instantsearch.widgets.panel({
    collapsed: ({ state }) => {
      return state.query.length === 0;
    },
    templates: {
      header: "Places",
    },
  })(instantsearch.widgets.refinementList)({
    container: "#rf-places",
    attribute: "place_entities.label",
    searchable: true,
    showMore: true,
    showMoreLimit: 50,
    limit: 10,
    searchablePlaceholder: "Search for places",
    cssClasses: DEFAULT_CSS_CLASSES,
  }),

  instantsearch.widgets.panel({
    collapsed: ({ state }) => {
      return state.query.length === 0;
    },
    templates: {
      header: "Keywords",
    },
  })(instantsearch.widgets.refinementList)({
    container: "#rf-keywords",
    attribute: "keyword_entities.label",
    searchable: true,
    showMore: true,
    showMoreLimit: 50,
    limit: 10,
    searchablePlaceholder: "Search for keywords",
    cssClasses: DEFAULT_CSS_CLASSES,
  }),
  /*
  instantsearch.widgets.panel({
    collapsed: ({ state }) => {
      return state.query.length === 0;
    },
    templates: {
      header: "Literatur",
    },
  })(instantsearch.widgets.refinementList)({
    container: "#rf-works",
    attribute: "bibl_entities.label",
    searchable: true,
    showMore: true,
    showMoreLimit: 50,
    limit: 10,
    searchablePlaceholder: "Suche nach Literatur",
    cssClasses: DEFAULT_CSS_CLASSES,
  }),
*/
  instantsearch.widgets.pagination({
    container: "#pagination",
    padding: 2,
    cssClasses: {
      list: "pagination",
      item: "page-item",
      link: "page-link",
    },
  }),
  instantsearch.widgets.clearRefinements({
    container: "#clear-refinements",
    templates: {
      resetLabel: "Filter zurücksetzen",
    },
    cssClasses: {
      button: "btn",
    },
  }),

  instantsearch.widgets.currentRefinements({
    container: "#current-refinements",
    cssClasses: {
      delete: "btn",
      label: "badge",
    },
    transformItems(items) {
      const labelMap = {
        "person_entities.label": "People",
        "place_entities.label": "Places",
        //        "bibl_entities.label": "Literatur",
      };

      return items.map((item) => ({
        ...item,
        label: labelMap[item.attribute] || item.label,
      }));
    },
  }),
]);

// Show/hide the Filter panel
const showFilter = document.querySelector("#filter-button");
const filters = document.querySelector("#refinements-section");
if (showFilter) {
  showFilter.addEventListener("click", function () {
    filters?.classList.toggle("d-none");
  });
}

search.addWidgets([
  instantsearch.widgets.configure({
    attributesToSnippet: ["full_text"],
  }),
]);

search.start();
