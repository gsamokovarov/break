# Changelog

## Unreleased

## 0.30.0 (2021-06-20)
### Added
- Officially Ruby 3.0 support. ([@gsamokovarov][])
### Fixed
- Fix broken `next` command for Ruby 2.7+. ([@gsamokovarov][])
- Fix circular require for `pry` integrations. ([@gsamokovarov][])

## 0.21.0 (2020-08-19)
### Fixed
- Fix broken `pry` commands like `ls`. ([@jamesfischer8][])

## 0.20.0 (2020-07-30)
### Added
- Support for `pry-remote`. ([@gsamokovarov][])
### Fixed
- Fix `up` and `down` commands in `pry`. ([@gsamokovarov][])

## 0.12.0 (2020-07-17)
### Added
- Support for `pry` version `0.13` and above. ([@gsamokovarov][])
### Fixed
- Fix a crash in multi-threaded environments. ([@gsamokovarov][])

## 0.11.0 (2020-02-08)
### Changed
- Requiring `pry` before `break` is no longer a prerequisite for automatic Pry integration. ([@gsamokovarov][])

[@gsamokovarov]: https://github.com/gsamokovarov
[@jamesfischer8]: https://github.com/jamesfischer8
