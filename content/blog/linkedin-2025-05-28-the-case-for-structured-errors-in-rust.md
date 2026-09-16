+++
title = "The Case for Structured Errors in Rust"
date = 2025-05-28
published_at = "2025-05-28T18:20:44.156Z"
source = "LinkedIn"
source_url = "https://www.linkedin.com/feed/update/urn:li:activity:7333557857549783040/"
activity_urn = "urn:li:activity:7333557857549783040"
source_post_number = 21
tags = ["Rust","Software Engineering"]
+++

I found this article on structured errors insightful. Although it is focused on Rust, the explanations of the direct benefits of encoding information about the failure surface of code are succinct and persuasive.

"Custom error types allow you to see all potential failure modes of a function at a glance, without (recursively) inspecting its implementation or maintaining fragile hand-written docs that can’t be fully trusted anyway. In a code review, you can easily notice when some error variant doesn’t make sense and should be handled locally, or comes from an action that shouldn’t be performed at all. Interfaces become more descriptive."

[https://lnkd.in/esm4w9WF](https://lnkd.in/esm4w9WF)
