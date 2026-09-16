(() => {
  const initializeTagFilter = () => {
    const filters = Array.from(document.querySelectorAll("input[data-tag-filter]"));
    const posts = Array.from(document.querySelectorAll(".post-row[data-tags]"));
    const tagButtons = Array.from(document.querySelectorAll("[data-tag-select]"));
    const status = document.querySelector("[data-filter-status]");
    const search = document.querySelector("#writing-search");
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
        const visible = matchesTag && matchesSearch;
        post.hidden = !visible;
        if (visible) visibleCount += 1;
      }

      for (const filter of filters) {
        filter.checked = filter.value === selectedTag;
      }
      if (status) {
        const queryDescription = normalizedQuery === "" ? "" : ` matching “${query.trim()}”`;
        const tagDescription = selectedTag === "" ? "" : ` tagged ${selectedTag}`;
        status.textContent = `Showing ${visibleCount} pieces${queryDescription}${tagDescription}.`;
      }
    };

    for (const filter of filters) {
      filter.addEventListener("change", () => {
        if (filter.checked) applyFilter(filter.value);
      });
    }

    for (const button of tagButtons) {
      button.addEventListener("click", () => applyFilter(button.dataset.tagSelect));
    }

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
