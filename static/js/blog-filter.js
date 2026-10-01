(() => {
  const initializeTagFilter = () => {
    const filters = Array.from(document.querySelectorAll("input[data-tag-filter]"));
    const posts = Array.from(document.querySelectorAll(".post-row[data-tags]"));
    const tagButtons = Array.from(document.querySelectorAll("[data-tag-select]"));
    const status = document.querySelector("[data-filter-status]");
    const search = document.querySelector("#writing-search");
    const empty = document.querySelector("[data-search-empty]");
    const clear = document.querySelector("[data-clear-filters]");
    const topics = document.querySelector(".topic-disclosure");
    const studyFilter = document.querySelector("[data-study-filter]");
    document.querySelector(".writing-index")?.classList.add("writing-filter-ready");
    if (topics && window.matchMedia("(min-width: 761px)").matches) topics.open = true;
    let currentQuery = search?.value ?? "";

    if (filters.length === 0 || posts.length === 0) return;

    const applyFilter = (selectedTag, query = currentQuery) => {
      let visibleCount = 0;
      currentQuery = query;
      const normalizedQuery = query.trim().toLocaleLowerCase();

      for (const post of posts) {
        const postTags = post.dataset.tags.split("|");
        const matchesTag = selectedTag === "" || postTags.includes(selectedTag);
        const matchesSearch = normalizedQuery === ""
          || (post.dataset.search ?? "").toLocaleLowerCase().includes(normalizedQuery);
        const matchesCollection = post.dataset.studyNote !== "true" || studyFilter?.checked;
        const visible = matchesCollection && matchesTag && matchesSearch;
        post.hidden = !visible;
        post.closest(".post-item").hidden = !visible;
        if (visible) visibleCount += 1;
      }

      for (const filter of filters) {
        filter.checked = filter.value === selectedTag;
      }
      if (empty) empty.hidden = visibleCount !== 0;
      if (status) {
        const queryDescription = normalizedQuery === "" ? "" : ` matching “${query.trim()}”`;
        const tagDescription = selectedTag === "" ? "" : ` tagged ${selectedTag}`;
        status.textContent = `Showing ${visibleCount} ${visibleCount === 1 ? "piece" : "pieces"}${queryDescription}${tagDescription}.`;
      }
    };

    studyFilter?.addEventListener("change", () => {
      const selected = filters.find((filter) => filter.checked);
      const unavailable = !studyFilter.checked && selected?.closest(".tag-choice").dataset.writingCount === "0";
      applyFilter(unavailable ? "" : selected?.value ?? "");
    });

    for (const filter of filters) {
      filter.addEventListener("change", () => {
        if (filter.checked) applyFilter(filter.value);
      });
    }

    for (const button of tagButtons) {
      button.addEventListener("click", () => applyFilter(button.dataset.tagSelect));
    }

    clear?.addEventListener("click", () => {
      if (search) search.value = "";
      if (studyFilter) studyFilter.checked = false;
      applyFilter("", "");
      search?.focus();
    });

    document.addEventListener("input", (event) => {
      if (event.target?.id !== "writing-search") return;
      applyFilter(filters.find((filter) => filter.checked)?.value ?? "", event.target.value);
    });

    applyFilter(filters.find((filter) => filter.checked)?.value ?? "");
  };

  if (document.readyState === "loading") {
    document.addEventListener("DOMContentLoaded", initializeTagFilter, { once: true });
  } else {
    initializeTagFilter();
  }
})();
