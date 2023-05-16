# Setup OhMyREPL and Revise
import Pkg
let
    pkgs = ["Revise", "OhMyREPL"]
    for pkg in pkgs
    if Base.find_package(pkg) === nothing
        Pkg.add(pkg)
    end
    end
end

using Revise
using OhMyREPL
using Crayons
using OhMyREPL: Passes.SyntaxHighlighter

scheme = SyntaxHighlighter.ColorScheme()

SyntaxHighlighter.symbol!(scheme, Crayon(foreground=(242, 205, 205)))
SyntaxHighlighter.comment!(scheme, Crayon(foreground=(127, 132, 156)))
SyntaxHighlighter.string!(scheme, Crayon(foreground=(166, 227, 161)))
SyntaxHighlighter.op!(scheme, Crayon(foreground=(137, 220, 235)))
SyntaxHighlighter.keyword!(scheme, Crayon(foreground=(203, 166, 247)))
SyntaxHighlighter.function_def!(scheme, Crayon(foreground=(137, 180, 250)))
SyntaxHighlighter.argdef!(scheme, Crayon(foreground=(249, 226, 175)))
SyntaxHighlighter.macro!(scheme, Crayon(bold=true, foreground=(203, 166, 247)))
SyntaxHighlighter.number!(scheme, Crayon(foreground=(250, 179, 135)))
SyntaxHighlighter.add!("catppuccin-mocha", scheme)

colorscheme!("catppuccin-mocha")

