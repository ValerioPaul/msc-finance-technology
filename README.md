# MSc Finance & Technology

The courses of my MSc in Finance & Technology at Roma Tre University, with the exercises and
projects I worked through in each. Every page is published as a website built with
[Zensical](https://zensical.org).

## Structure

```
docs/
├── index.md                          home: one card per course
└── <course>/
    ├── index.md                      what the course covers, and its parts
    ├── part-1/ …                     one folder per part of the course
    │   ├── index.md                  the list of exercises in that part
    │   └── <exercise>/
    │       ├── index.md              problem, method, code, results, takeaways
    │       ├── S_*.m, F_*.m          the code, included in the page as it is
    │       ├── data files            what the code reads
    │       └── exN-figK.png          the charts the code produces
    └── exams/                        the written exams, as submitted, with a review
```

Every exercise folder is self-contained: download it and the scripts run in MATLAB as they
are. The page shows the `.m` files themselves (through `pymdownx.snippets`), so the code on
the site is always the code in the folder.

- **New exercise:** add a folder inside its part, add one line for it in `nav` in
  `zensical.toml`, and link it from the part's `index.md`.
- **New course:** add a folder under `docs/` with an `index.md`, add a block for it in `nav`,
  and add its card to `docs/index.md`.

Code and charts are the final, tested versions: the site displays them, it does not run them.

## Local preview

```bash
python3 -m venv .venv
./.venv/bin/pip install -r requirements.txt
./.venv/bin/zensical serve        # http://localhost:8000
```

## Deploy

Vercel builds the site on every push to `main`, following `vercel.json`:
install `requirements.txt`, run `zensical build`, publish `site/`.
