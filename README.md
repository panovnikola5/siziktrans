# Sizik Trans — Operations Ledger

Static HTML prototype for monthly credit-note, fuel, toll and other invoice records.

## Run locally
Open `index.html` in a modern browser. The app uses browser `localStorage` for its records. Uploaded PDFs are stored in that browser and can be previewed there.

## Host on GitHub Pages
1. Create a GitHub repository.
2. Upload `index.html` to the repository root.
3. In repository Settings → Pages, choose deploy from the `main` branch and `/ (root)`.
4. Open the generated Pages URL.

## Important limitations
- Data is stored in the current browser only; it is not a shared multi-user database. Moving to another browser/device does not sync records.
- The PIN is a basic client-side gate, not secure authentication.
- PDF text extraction and spreadsheet parsing depend on external browser libraries loaded from CDNs, so a network connection is needed for those functions. PDFs are still retained for preview if text extraction fails.
- Always verify extracted amounts against the source document.
