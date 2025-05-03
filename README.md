# CTU Thesis Review Report Template

This project provides an **unofficial LaTeX template** for writing **reviewer** or **supervisor reports** for **bachelor** and **master theses** at the **Czech Technical University in Prague (ČVUT / CTU)**.

Originally created by Michal Neoral for personal use, this template replicates the official Word-based layout used in KOS and has been made publicly available for broader academic use.

---

## 🧰 Features

- Supports **Czech** and **English** (`lang=cz` / `lang=en`)
- Role-based layout: **Reviewer** or **Supervisor**
- Compatible with **Bachelor** and **Master** theses
- Optional hiding of help text (`wouthelp`)
- Automatic date generation or manual override
- Predefined structured sections for evaluation
- CTU branding with logos and metadata

---

## 📂 Project Structure

```
.
├── main.tex                       # Main LaTeX file to compile - your input and settings
├── ctu_review_report/
│   ├── ctu_review_report.cls      # Main class file
│   ├── logo_CTU_cb.pdf            # English CTU logo
│   ├── logo_CVUT_cb.pdf           # Czech CTU logo
```

---

## 🚀 Getting Started

You can use this template either:

- 🟢 **Online** via [Overleaf](https://www.overleaf.com/) — recommended for convenience and collaboration  
- ⚙️ **Locally** on your machine — if you prefer full control over your LaTeX environment

---

## 🚀 Getting Started — Overleaf

1. **Download ZIP**  
   Go to the [GitHub repository](https://github.com/michalneoral/CTU-template-for-thesis-reviews) and click  
   **Code → Download ZIP**.

2. **Upload to Overleaf**  
   - Open [Overleaf](https://www.overleaf.com/)
   - Click **"New Project" → "Upload Project"**
   - Select the downloaded `.zip` file

That’s it — Overleaf will automatically recognize `main.tex` as the main entry point and compile the project.

> ℹ️ _In the future, this template will be available directly in Overleaf’s **Institutional Templates** section for CTU users._

---

## 🚀 Getting Started — Local


### 1. Clone the repository

```bash
git clone https://github.com/michalneoral/CTU-template-for-thesis-reviews.git
cd CTU-template-for-thesis-reviews
```

### 2. Compile the report

Use a LaTeX engine like `pdflatex`, `xelatex`, or `lualatex`:

```bash
pdflatex main.tex
```

Repeat the compilation twice if needed.

---

## ⚙️ Configuration

Set the document class in `main.tex` with the desired options:

```latex
\documentclass[lang=cz,thesistype=master,iam=reviewer]{ctu_review_report/ctu_review_report}
```

Available options:

- `lang=cz` or `lang=en` — Language
- `thesistype=master` or `thesistype=bachelor` — Thesis type
- `iam=reviewer` or `iam=supervisor` — Your role
- `wouthelp` — Disable grey instructional text in output

---

## 📝 Filling Out the Template

Replace all `\DeleteMeAnd...` placeholder commands with your actual content. Example:

```latex
\reviewerName{prof. Ing. Pavel Novák, Ph.D.}
\thesisTitle{Efficient Algorithms for Distributed Graph Processing}
\thesisAuthor{Bc. Jan Novotný}
\faculty{FEL}
```

Each evaluation box is controlled via macros like:

```latex
\evalAssignment{b}{
Your comment here...
}
```

Use predefined grade codes:
- For difficulty: `a`, `b`, `c`, `d`, `e`
- For marks: `A`, `B`, `C`, `D`, `E`, `F`

---

## 🏛 Supported Faculties

The following abbreviations are supported by the `\faculty{}` macro:

- `FEL`, `FIT`, `FS`, `FSV`, `FJFI`, `FBMI`, `FA`, `FD`, `MIAS`, `MUVS`
- it works for both English and Czech abbreviations

Example:

```latex
\faculty{FEL}
```

---

## 📄 License & Disclaimer

This template is **unofficial** and provided **as-is without warranty**. Use at your own risk.

Based on layouts available in [KOS](https://kos.cvut.cz) and the CTU [thesis instructions page](https://comtel.fel.cvut.cz/cs/instrukce-pro-zaverecne-prace).

---

## 🙋 Author

Created by **Michal Neoral**  
📧 neoramic@fel.cvut.cz  
📧 michalneoral@email.cz

---

## 🤝 Contributions

Pull requests and suggestions are welcome. If you find bugs or have improvement ideas, feel free to open an issue or submit a PR.
