## [Unreleased]

## [1.0.2] - 2022-11-25

- Updates hook to use `site.keep_files` instead of `site.config["keep_files"]`

## [1.0.1] - 2022-11-20

- Adds hook that includes `.well-known/webfinger` in the `keep_files` config

## [1.0.0] - 2022-11-19

- Initial release
- Generates `/.well-known/webfinger` file that points to a Mastodon profile defined in `_config.yml`
