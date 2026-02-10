# R/_preflight_packages.R
# Preflight: scan all .Rmd files for package usage and ensure they are installed.
# - Detects: library(pkg), require(pkg), pkg::fun, requireNamespace("pkg")
# - Installs missing packages.
# - Optionally uses renv (if lockfile exists) to restore prior to scan.

preflight_install <- function(pkgs) {
  pkgs <- unique(pkgs[!is.na(pkgs) & nzchar(pkgs)])
  if (length(pkgs) == 0) return(invisible(TRUE))
  
  # Prefer pak if available (fast, resolves binaries), else install.packages
  if (requireNamespace("pak", quietly = TRUE)) {
    pak::pak(pkgs)
  } else {
    install.packages(pkgs, dependencies = TRUE)
  }
}

extract_pkgs_from_lines <- function(lines) {
  # Detect library() / require()
  pat_libreq <- "\\b(?:library|require)\\s*\\(\\s*([A-Za-z][A-Za-z0-9\\.]+)"
  m1 <- regmatches(lines, gregexpr(pat_libreq, lines, perl = TRUE))
  p1 <- unlist(lapply(m1, function(x) {
    if (length(x) == 0) return(character())
    sub(pat_libreq, "\\1", x, perl = TRUE)
  }))
  
  # Detect package::function
  # Avoid catching :: inside code fences that are not R? We keep it simple here.
  pat_colon <- "\\b([A-Za-z][A-Za-z0-9\\.]+)\\s*::"
  m2 <- regmatches(lines, gregexpr(pat_colon, lines, perl = TRUE))
  p2 <- unlist(lapply(m2, function(x) {
    if (length(x) == 0) return(character())
    sub(pat_colon, "\\1", x, perl = TRUE)
  }))
  
  # Detect requireNamespace("pkg")
  pat_rns <- "requireNamespace\\s*\\(\\s*'\"['\"]"
  m3 <- regmatches(lines, gregexpr(pat_rns, lines, perl = TRUE))
  p3 <- unlist(lapply(m3, function(x) {
    if (length(x) == 0) return(character())
    sub(pat_rns, "\\1", x, perl = TRUE)
  }))
  
  unique(c(p1, p2, p3))
}

scan_rmd_packages <- function(root = ".") {
  files <- list.files(root, pattern = "\\.Rmd$", recursive = TRUE, full.names = TRUE)
  if (length(files) == 0) return(character())
  pkgs <- character()
  for (f in files) {
    lines <- readLines(f, warn = FALSE)
    pkgs <- c(pkgs, extract_pkgs_from_lines(lines))
  }
  # Exclude base/recommended always-available core packages (optional)
  base_like <- c("base","stats","utils","graphics","grDevices","methods","datasets")
  setdiff(unique(pkgs), base_like)
}

ensure_book_packages <- function(root = ".",
                                 use_renv = TRUE,
                                 renv_restore_first = TRUE) {
  # 1) If renv is present and requested, activate/restore first
  if (use_renv && file.exists(file.path(root, "renv.lock"))) {
    if (!requireNamespace("renv", quietly = TRUE)) {
      install.packages("renv")
    }
    renv::activate(root)
    if (renv_restore_first) {
      message("[preflight] Restoring packages from renv.lock …")
      renv::restore(prompt = FALSE)
    }
  }
  
  # 2) Scan .Rmd files for packages
  message("[preflight] Scanning .Rmd files for package usage …")
  pkgs <- scan_rmd_packages(root)
  
  # 3) Install missing packages (those not available)
  missing <- pkgs[!vapply(pkgs, requireNamespace, FUN.VALUE = logical(1), quietly = TRUE)]
  if (length(missing)) {
    message("[preflight] Installing missing packages: ", paste(missing, collapse = ", "))
    preflight_install(missing)
  } else {
    message("[preflight] No missing packages detected.")
  }
  
  invisible(pkgs)
}

# Run automatically when sourced:
ensure_book_packages(".")