# Tests

Each case's production looks like:
`build/artifacts/<degree>-<language>-<output>/{full,focused}/{latex,typst}.pdf`.

| Workflow value | ThuThesis | TnTT |
| --- | --- | --- |
| `chinese` | `language=chinese` | `lang=zh` |
| `english` | `language=english` | `lang=en` |
| `electronic` | `output=electronic` | `twoside=false` |
| `print` | `output=print` | `twoside=true` |
