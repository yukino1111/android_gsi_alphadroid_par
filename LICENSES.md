# License scope

The root `LICENSE` applies Apache-2.0 only to original scripts,
documentation, and repository metadata that do not carry another notice.

Files under `patches/` are diffs against the independent upstream projects
and revisions recorded by `patches/series.tsv` and `manifest/locked.xml`.
Each patch retains the copyright notices and license of its upstream project;
this repository does not relicense those changes under Apache-2.0.
Original patch authors and the PAR-specific ownership boundary are recorded in
`ATTRIBUTION.md`.

Browser/WebView APKs, signing keys,
generated images, stock vendor XML files, and other private or proprietary
build inputs are not part of this repository. The Huawei UniPerf HIDL file is a
minimal independently written compatibility interface, not a vendor service
implementation.
