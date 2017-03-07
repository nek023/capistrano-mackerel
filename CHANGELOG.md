# Change Log

## [v0.2.0](https://github.com/questbeat/capistrano-mackerel/tree/v0.2.0) (2017-03-06)
[Full Changelog](https://github.com/questbeat/capistrano-mackerel/compare/v0.1.0...v0.2.0)

### Added
- Output processing time to log
- Abort when the task in `:mackerel_annotate_tasks` is not defined
- Automatically remove duplication from `:mackerel_annotate_tasks`

### Changed
- Skip creating annotation when `:mackerel_api_key` is not defined

### Fixed
- Fix it doesn't work when multiple tasks are specified to `:mackerel_annotate_tasks`


## [v0.1.0](https://github.com/questbeat/capistrano-mackerel/tree/v0.1.0) (2017-03-02)
- Initial release
