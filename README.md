# Sizik Trans

Sizik Trans is a monthly operations and revenue ledger for credit notes, loads, fuel reports, toll invoices and other costs.

## Fuel report quantity totals

Each imported fuel invoice shows **Diesel litres**, **AdBlue litres**, and **total quantity**. The app sums the `Quantity` column (M) by the actual `Product` column (L), not `ProductID`. The fuel invoice total uses `EUR NetAmount` (column AP). No separate Diesel/AdBlue price totals are calculated.

## Set up shared cloud storage with Supabase

The included website supports Supabase authentication, a shared ledger database and private document uploads. The cloud connection is not live until you configure your own Supabase project.

1. Create a project at https://supabase.com.
2. In Supabase, open **SQL Editor**, create a new query, paste all of `supabase-setup.sql`, and run it.
3. In Supabase **Project Settings → API**, copy the **Project URL** and the **anon/public key**. Do **not** use or expose the `service_role` key.
4. Edit `supabase-config.js`, replacing `https://YOUR_PROJECT_ID.supabase.co` and `YOUR_SUPABASE_ANON_PUBLIC_KEY` with your project's values.
5. In Supabase **Authentication → Providers**, enable Email sign-in. If you want to invite only approved employees, disable public sign-ups and create team users from the Supabase dashboard; otherwise use the app's **Create account** button.
6. Upload `index.html`, `supabase-config.js`, and `supabase-setup.sql` (optional after setup) to the root of your GitHub repository. In GitHub **Settings → Pages**, publish from the `main` branch and `/ (root)`.
7. Open the published site and sign in. Authenticated team members share the same ledger and can preview documents uploaded to the private `sizik-documents` bucket.

### Access and safety

- The browser needs internet access for Supabase, PDF.js and SheetJS.
- All authenticated accounts in this project's policies share the same company ledger. Only give accounts to people who should see company records.
- The website contains only the Supabase **anon/public** key. Never put a `service_role` key in client-side files.
- Supabase stores the shared ledger JSON in Postgres and the original uploaded files in private Storage. Local PIN mode remains available as a local-only fallback when Supabase is not configured; it does not sync with the cloud.
- Keep regular exports/backups. Cloud storage is not a replacement for backups.

## Publish with GitHub Pages

1. Create a GitHub repository.
2. Upload the files above to the repository root.
3. In **Settings → Pages**, choose **Deploy from a branch**, select `main` and `/ (root)`, and save.
4. Wait for GitHub Pages to publish the site.

## Import notes

- Fuel data mapping defaults to `EUR NetAmount` (AP), `Quantity` (M), `Product` (L), `PlateNr` (O), `TrsDate` (I), `InvoiceDate` (X), `InvoiceNr` (Y), and `StationName` (G).
- Imported invoice reports are grouped by invoice number and invoice date. Check totals against the source Excel before using for accounting.
