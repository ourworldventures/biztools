# Ourworld Free Zone

> see [https://despiegk.github.io/...]()

```bash
cd /tmp
curl -L https://github.com/ourworldventures/biztools/releases/download/initial/bizplanner_arm64 > bizplanner
chmod +x bizplanner
./bizplanner
```

## Requirements make sure redis is running

```bash
brew install redis
brew services start redis
```

## To Develop for Planning tool

> todo

## To Develop for MDBook

### Requirements

- Make
- [mdbook](https://rust-lang.github.io/mdBook/guide/installation.html)

### build

`make build`

### Serve

`make serve`

will open the browser  

### Contribute

If you want to contribute, you should follow this steps:

1. Add the md file to [src](./src) directory.
2. Add the path of the md file to [SUMMARY](./src/SUMMARY.md).
3. Then use `make build` and `make serve` to see your changes on the browser.
