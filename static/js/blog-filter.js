(() => {
  const initializeTagFilter = () => {
    const filters = Array.from(document.querySelectorAll("input[data-tag-filter]"));
    const posts = Array.from(document.querySelectorAll(".post-row[data-tags]"));

    if (filters.length === 0 || posts.length === 0) return;

    const tagButtons = Array.from(document.querySelectorAll("[data-tag-select]"));
    const status = document.querySelector("[data-filter-status]");
    const search = document.querySelector("#writing-search");
    const empty = document.querySelector("[data-search-empty]");
    const clear = document.querySelector("[data-clear-filters]");
    const topicLabel = document.querySelector("[data-topic-label]");
    const studyFilter = document.querySelector("[data-study-filter]");
    document.querySelector(".writing-index")?.classList.add("writing-filter-ready");
    let currentQuery = "";
    let currentTag = "";

    const applyFilter = (selectedTag, query = currentQuery, updateUrl = true) => {
      const selected = filters.find(filter => filter.value === selectedTag);
      const unavailable = !studyFilter?.checked && selected?.closest(".tag-choice")?.dataset.writingCount === "0";
      currentTag = selected && !unavailable ? selectedTag : "";
      currentQuery = query;

      if (search) search.value = query;
      const normalizedQuery = query.trim().toLocaleLowerCase();
      let visibleCount = 0;

      for (const post of posts) {
        const matchesTag = currentTag === "" || post.dataset.tags.split("|").includes(currentTag);

        const matchesSearch = normalizedQuery === ""
          || (post.dataset.search ?? "").toLocaleLowerCase().includes(normalizedQuery);

        const matchesCollection = post.dataset.studyNote !== "true" || studyFilter?.checked;
        const visible = matchesCollection && matchesTag && matchesSearch;
        post.hidden = !visible;
        post.closest(".post-item").hidden = !visible;

        if (visible) visibleCount += 1;
      }

      for (const filter of filters) filter.checked = filter.value === currentTag;

      if (empty) empty.hidden = visibleCount !== 0;

      if (clear) clear.hidden = currentTag === "" && normalizedQuery === "" && !studyFilter?.checked;

      if (topicLabel) topicLabel.textContent = currentTag || "Topics";

      if (status) {
        const queryDescription = normalizedQuery === "" ? "" : ` matching “${query.trim()}”`;
        const tagDescription = currentTag === "" ? "" : ` tagged ${currentTag}`;
        status.textContent = `Showing ${visibleCount} ${visibleCount === 1 ? "piece" : "pieces"}${queryDescription}${tagDescription}.`;
      }

      if (updateUrl) {
        const url = new URL(window.location.href);

        for (const [key, value] of [["topic", currentTag], ["q", query.trim()], ["study", studyFilter?.checked ? "1" : ""]]) {
          if (value) url.searchParams.set(key, value);
          else url.searchParams.delete(key);
        }

        window.history.replaceState(null, "", url.pathname + url.search + url.hash);
      }
    };

    const restoreFromUrl = () => {
      const params = new URLSearchParams(window.location.search);

      if (studyFilter) studyFilter.checked = params.get("study") === "1";
      applyFilter(params.get("topic") ?? "", params.get("q") ?? "", false);
    };

    studyFilter?.addEventListener("change", () => applyFilter(currentTag));

    for (const filter of filters) {
      filter.addEventListener("change", () => {
        if (filter.checked) applyFilter(filter.value);
      });
    }

    for (const button of tagButtons) {
      button.addEventListener("click", () => applyFilter(button.dataset.tagSelect));
    }

    clear?.addEventListener("click", () => {
      if (studyFilter) studyFilter.checked = false;
      applyFilter("", "");
      search?.focus();
    });
    search?.addEventListener("input", () => applyFilter(currentTag, search.value));
    window.addEventListener("popstate", restoreFromUrl);
    restoreFromUrl();
  };

  if (document.readyState === "loading") {
    document.addEventListener("DOMContentLoaded", initializeTagFilter, { once: true });
  } else {
    initializeTagFilter();
  }
})();
