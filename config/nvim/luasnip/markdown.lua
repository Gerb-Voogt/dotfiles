-- Not working?
local in_mathzone = function()
    return vim.fn['vimtex#syntax#in_mathzone']() == 1
end

return {
    ----------------------
    --- Other Snippets ---
    ----------------------
    s({trig="insimg", dscr="Insert an image env"},
        fmt( -- The snippet code actually looks like the equation environment it produces.
            [[
              ![<>](images/<>){width=50%}
            ]],
            { i(1), i(2)},
            { delimiters = "<>" }
        )
    ),

    --------------------
    --- Enviroments  ---
    --------------------
    s({trig="\\theorem", dscr="A makeshift boxed theorme environment"},
        fmt( -- The snippet code actually looks like the equation environment it produces.
            [[
              \fbox{\parbox{\columnwidth}{
              \textbf{Theorem \textnormal{(<>)}.}\textit{
              <>
              }}}
            ]],
            { i(1), i(2)},
            { delimiters = "<>" }
        )
    ),
    s({trig="\\lemma", dscr="A makeshift boxed lemma environment"},
        fmt( -- The snippet code actually looks like the equation environment it produces.
            [[
              \fbox{\parbox{\columnwidth}{
              \textbf{Lemma \textnormal{(<>)}.}\textit{
              <>
              }}}
            ]],
            { i(1), i(2)},
            { delimiters = "<>" }
        )
    ),
    s({trig="\\definition", dscr="A makeshift boxed definition environment"},
        fmt( -- The snippet code actually looks like the equation environment it produces.
            [[
              \fbox{\parbox{\columnwidth}{
              \textbf{Definition \textnormal{(<>)}.}\textit{
              <>
              }}}
            ]],
            { i(1), i(2)},
            { delimiters = "<>" }
        )
    ),
    s({trig="\\example", dscr="A makeshift boxed example environment"},
        fmt( -- The snippet code actually looks like the equation environment it produces.
            [[
              \fbox{\parbox{\columnwidth}{
              \textbf{Example \textnormal{(<>)}.}
              <>
              }}
            ]],
            { i(1), i(2)},
            { delimiters = "<>" }
        )
    ),
    s({trig="\\proof", dscr="A makeshift boxed proof environment"},
        fmt( -- The snippet code actually looks like the equation environment it produces.
            [[
              \fbox{\parbox{\columnwidth}{
              \textbf{Proof \textnormal{(<>)}.}
              <>
              }}
            ]],
            { i(1), i(2)},
            { delimiters = "<>" }
        )
    ),
    s({trig="\\problem", dscr="A makeshift boxed problem environment"},
        fmt( -- The snippet code actually looks like the equation environment it produces.
            [[
              \fbox{\parbox{\columnwidth}{
              \textbf{Problem \textnormal{(<>)}.}\textit{
              <>
              }}}
            ]],
            { i(1), i(2)},
            { delimiters = "<>" }
        )
    ),
    s({trig="\\note", dscr="A makeshift boxed note environment"},
        fmt( -- The snippet code actually looks like the equation environment it produces.
            [[
              \fbox{\parbox{\columnwidth}{
              \textbf{Note \textnormal{(<>)}.}
              <>
              }}
            ]],
            { i(1), i(2)},
            { delimiters = "<>" }
        )
    ),
    s({trig="begin", dscr="A LaTeX environment"},
        fmt( -- The snippet code actually looks like the equation environment it produces.
            [[
              \begin{<>}
                  <>
              \end{<>}
            ]],
            { i(1), i(2), rep(1)},
            { delimiters = "<>" }
        )
    ),
    s({trig="align", dscr="A LaTeX align environment"},
        fmta( -- The snippet code actually looks like the equation environment it produces.
            [[
              \begin{align}
                  <>
              \end{align}
            ]],
            { i(1), },
            { condition = in_mathzone}
        )
    ),
    s({trig="align*", dscr="A LaTeX align* environment"},
        fmta( -- The snippet code actually looks like the equation environment it produces.
            [[
              \begin{align*}
                  <>
              \end{align*}
            ]],
            { i(1), },
            { condition = in_mathzone}
        )
    ),
    s({trig="gather", dscr="A LaTeX gather environment"},
        fmt( -- The snippet code actually looks like the equation environment it produces.
            [[
            \begin{gather}
            <>
            \end{gather}
            ]],
            { i(1) },
            { delimiters = "<>" }
        )
    ),
    s({trig="gather*", dscr="A LaTeX gather* environment"},
        fmt( -- The snippet code actually looks like the equation environment it produces.
            [[
            \begin{gather*}
            <>
            \end{gather*}
            ]],
            { i(1) },
            { delimiters = "<>" }
        )
    ),
    s({trig="cases", dscr="A LaTeX cases environment"},
        fmt( -- The snippet code actually looks like the equation environment it produces.
            [[
            \begin{cases}
            <>
            \end{cases}
            ]],
            { i(1) },
            { delimiters = "<>" }
        )
    ),
    s({trig="equation", dscr="A LaTeX equation environment"},
        fmt( -- The snippet code actually looks like the equation environment it produces.
            [[
            \begin{equation}
            <>
            \end{equation}
            ]],
            { i(1) },
            { delimiters = "<>" }
        )
    ),
    s({trig="equation*", dscr="A LaTeX equation* environment"},
        fmt( -- The snippet code actually looks like the equation environment it produces.
            [[
            \begin{equation*}
            <>
            \end{equation*}
            ]],
            { i(1) },
            { delimiters = "<>" }
        )
    ),
    s({trig="$$", dscr="A LaTeX gather environment", snippetType="autosnippet"},
        fmt( 
            [[
            $$
            <>
            $$
            ]],
            { i(1) },
            { delimiters = "<>" }
        )
    ),
    s({trig="mk", dscr="inline math", snippetType="autosnippet"},
        fmt( 
            "$<>$",
            { i(1) },
            { delimiters = "<>" }
        )
    ),

    -----------------------------
    --- Symbols and Functions ---
    -----------------------------
    s({trig="///", dscr="latex frac", snippetType="autosnippet"},
        fmt( 
            "\\frac{<>}{<>}",
            { i(1), i(2) },
            { delimiters = "<>" }
        )
    ),
    s({trig="lim", dscr="latex lim function"},
        fmt( 
            "\\lim_{<>}",
            { i(1) },
            { delimiters = "<>" }
        )
    ),
    s({trig="func", dscr="function definition"},
        fmt( 
            "<> : <> \\to <>",
            { i(1), i(2), i(3) },
            { delimiters = "<>" }
        )
    ),
    s({trig="sin", dscr="latex sin function"},
        fmt(
            "\\sin(<>)",
            { i(1) },
            { delimiters = "<>" }
        )
    ),
    s({trig="exp", dscr="exponential function"},
        fmt(
            "\\exp(<>)",
            { i(1) },
            { delimiters = "<>" }
        )
    ),
    s({trig="det", dscr="Matrix determinant function"},
        fmt(
            "\\text{det}(<>)<>",
            { i(1), i(2) },
            { delimiters = "<>" }
        )
    ),
    s({trig="arcsin", dscr="latex arcsin function"},
        fmt(
            "\\arcsin(<>)",
            { i(1) },
            { delimiters = "<>" }
        )
    ),
    s({trig="cos", dscr="latex cos function"},
        fmt(
            "\\cos(<>)",
            { i(1) },
            { delimiters = "<>" }
        )
    ),
    s({trig="arccos", dscr="latex arccos function"},
        fmt(
            "\\arccos(<>)",
            { i(1) },
            { delimiters = "<>" }
        )
    ),
    s({trig="tan", dscr="latex tan function"},
        fmt(
            "\\tan(<>)",
            { i(1) },
            { delimiters = "<>" }
        )
    ),
    s({trig="arctan", dscr="latex arctan function"},
        fmt(
            "\\arctan(<>)",
            { i(1) },
            { delimiters = "<>" }
        )
    ),
    s({trig="sqrt", dscr="latex sqrt function"},
        fmt(
            "\\sqrt{<>}",
            { i(1) },
            { delimiters = "<>" }
        )
    ),
    s({trig="diff", dscr="derrivative"},
        fmt(
            "\\frac{d <>}{d <>}<>",
            { i(1), i(2), i(3) },
            { delimiters = "<>" }
        )
    ),
    s({trig="pdiff", dscr="partial derrivative"},
        fmt(
            "\\frac{\\partial <>}{\\partial <>}<>",
            { i(1), i(2), i(3) },
            { delimiters = "<>" }
        )
    ),
    s({trig="adiff", dscr="anti derrivative"},
        fmt(
            "\\int <>\\, d <>",
            { i(1), i(2),},
            { delimiters = "<>" }
        )
    ),
    s({trig="sum", dscr="latex sum construct"},
        fmt(
            "\\sum_{<>}^{<>}",
            { i(1), i(2) },
            { delimiters = "<>" }
        )
    ),
    s({trig="prod", dscr="latex prod construct"},
        fmt(
            "\\prod_{<>}^{<>} <>",
            { i(1), i(2), i(3) },
            { delimiters = "<>" }
        )
    ),
    s({trig="int", dscr="latex integral construct"},
        fmt(
            "\\int_{<>}^{<>} <>\\, d<>",
            { i(1), i(2), i(3), i(4) },
            { delimiters = "<>" }
        )
    ),
    s({trig="oint", dscr="latex boundary integral construct"},
        fmt(
            "\\oint_{<>} <>\\, d<>",
            { i(1), i(2), i(3) },
            { delimiters = "<>" }
        )
    ),
    s({trig="inn", dscr="latex in symbol", snippetType="autosnippet"},
        fmt(
            "\\in <>",
            { i(1) },
            { delimiters = "<>" }
        )
    ),
    s({trig="forall", dscr="latex forall symbol"},
        fmt(
            "\\forall <>",
            { i(1) },
            { delimiters = "<>" }
        )
    ),
    s({trig="exists", dscr="latex exists symbol"},
        fmt(
            "\\exists <>",
            { i(1) },
            { delimiters = "<>" }
        )
    ),
    s({trig="set", dscr="latex exists symbol"},
        fmt(
            "\\{<>\\}<>",
            { i(1), i(2) },
            { delimiters = "<>" }
        )
    ),
    s({trig="|->", dscr="mapsto"},
        fmt(
            "\\mapsto <>",
            { i(1) },
            { delimiters = "<>" }
        )
    ),
    s({trig="->", dscr="rightarrow"},
        fmt(
            "\\rightarrow <>",
            { i(1) },
            { delimiters = "<>" }
        )
    ),
    s({trig="=>", dscr="implies"},
        fmt(
            "\\Rightarrow <>",
            { i(1) },
            { delimiters = "<>" }
        )
    ),
    s({trig="<=>", dscr="iff"},
        fmt(
            "\\Leftrightarrow <>",
            { i(1) },
            { delimiters = "<>" }
        )
    ),
    s({trig=">=", dscr="geq"},
        fmt(
            "\\geq <>",
            { i(1) },
            { delimiters = "<>" }
        )
    ),
    s({trig="<=", dscr="leq"},
        fmt(
            "\\leq <>",
            { i(1) },
            { delimiters = "<>" }
        )
    ),
    s({trig="!=", dscr="neq"},
        fmt(
            "\\neq <>",
            { i(1) },
            { delimiters = "<>" }
        )
    ),
    s({trig="text", dscr="latex text in mathmode function"},
        fmt( 
            "\\text{<>}",
            { i(1) },
            { delimiters = "<>" }
        )
    ),
    s({trig="Re", dscr="Real part"},
        fmt( 
            "\\text{Re}(<>)<>",
            { i(1), i(2) },
            { delimiters = "<>" }
        )
    ),
    s({trig="Im", dscr="Imaginary part"},
        fmt( 
            "\\text{Im}(<>)<>",
            { i(1), i(2) },
            { delimiters = "<>" }
        )
    ),
    s({trig="bf", dscr="latex boldsymbol", snippetType="autosnippet"},
        fmt( 
            "\\mathbf{<>}",
            { i(1) },
            { delimiters = "<>" }
        )
    ),
    s({trig="mbf", dscr="latex boldsymbol", snippetType="autosnippet"},
        fmt( 
            "\\boldsymbol{<>}",
            { i(1) },
            { delimiters = "<>" }
        )
    ),
    s({trig="mbb", dscr="latex blackboard bold letters", snippetType="autosnippet"},
        fmt( 
            "\\mathbb{<>}",
            { i(1) },
            { delimiters = "<>" }
        )
    ),
    s({trig="cdot", dscr="cdot", snippetType="autosnippet"},
        fmt( 
            "\\cdot <>",
            { i(1) },
            { delimiters = "<>" }
        )
    ),
    s({trig="....", dscr="cdots", snippetType="autosnippet"},
        fmt( 
            "\\cdots <>",
            { i(1) },
            { delimiters = "<>" }
        )
    ),
    s({trig="pair", dscr="tansformation pair"},
        fmt( 
            "\\xleftrightarrow[]{\\mathcal{<>}}<>",
            { i(1), i(2) },
            { delimiters = "<>" }
        )
    ),


    ---------------
    --- LETTERS ---
    ---------------
    s({trig="mcal", dscr="mathcal letters", snippetType="autosnippet"},
        fmt( 
            "\\mathcal{<>}",
            { i(1) },
            { delimiters = "<>" }
        )
    ),
    -- s({trig="RR", dscr="latex Real numbers symbol", snippetType="autosnippet"},
    --     fmt( 
    --         "\\mathbb{R}<>",
    --         { i(1) },
    --         { delimiters = "<>" }
    --     )
    -- ),
    s({trig="ZZ", dscr="latex Integer  numbers symbol", snippetType="autosnippet"},

        fmt(
            "\\mathbb{Z}<>",
            { i(1) },
            { delimiters = "<>" }
        )
    ),
    s({trig="CC", dscr="latex Complex symbol", snippetType="autosnippet"},
        fmt(
            "\\mathbb{C}<>",
            { i(1) },
            { delimiters = "<>" }
        )
    ),
    s({trig="QQ", dscr="latex Rationals  numbers symbol", snippetType="autosnippet"},
        fmt( 
            "\\mathbb{Q}<>",
            { i(1) },
            { delimiters = "<>" }
        )
    ),
    s({trig="EE", dscr="Expected value symbol"},
        fmt( 
            "\\mathbb{E}\\left[<>\\right]",
            { i(1) },
            { delimiters = "<>" }
        )
    ),
    s({trig="OO", dscr="Order", snippetType="autosnippet"},
        fmt( 
            "\\mathcal{O}(<>)<>",
            { i(1), i(2) },
            { delimiters = "<>" }
        )
    ),
    s({trig="LL", dscr="Laplace", snippetType="autosnippet"},
        fmt( 
            "\\mathcal{L}[<>]<>",
            { i(1), i(2) },
            { delimiters = "<>" }
        )
    ),
    s({trig="FF", dscr="Order", snippetType="autosnippet"},
        fmt( 
            "\\mathcal{F}[<>]<>",
            { i(1), i(2) },
            { delimiters = "<>" }
        )
    ),
    s({trig="nabla", dscr="nabla"},
        fmt( 
            "\\nabla<>",
            { i(1) },
            { delimiters = "<>" }
        )
    ),
    s({trig="partial", dscr="partial"},
        fmt( 
            "\\partial<>",
            { i(1) },
            { delimiters = "<>" }
        )
    ),
    s({trig="ooo", dscr="infty", snippetType="autosnippet"},
        fmt( 
            "\\infty<>",
            { i(1) },
            { delimiters = "<>" }
        )
    ),
    s({trig="@a", dscr="latex alpha symbol", snippetType="autosnippet"},
        fmt(
            "\\alpha<>",
            { i(1) },
            { delimiters = "<>" }
        )
    ),
    s({trig="@b", dscr="latex beta symbol", snippetType="autosnippet"},
        fmt(
            "\\beta<>",
            { i(1) },
            { delimiters = "<>" }
        )
    ),
    s({trig="@g", dscr="latex alpha symbol", snippetType="autosnippet"},
        fmt( 
            "\\gamma<>",
            { i(1) },
            { delimiters = "<>" }
        )
    ),
    s({trig="@d", dscr="latex delta symbol", snippetType="autosnippet"},
        fmt(
            "\\delta<>",
            { i(1) },
            { delimiters = "<>" }
        )
    ),
    s({trig="@D", dscr="latex Delta symbol", snippetType="autosnippet"},
        fmt(
            "\\Delta<>",
            { i(1) },
            { delimiters = "<>" }
        )
    ),
    s({trig="@e", dscr="latex epsilon symbol", snippetType="autosnippet"},
        fmt( 
            "\\varepsilon<>",
            { i(1) },
            { delimiters = "<>" }
        )
    ),
    s({trig="@z", dscr="latex zeta symbol", snippetType="autosnippet"},
        fmt( 
            "\\zeta<>",
            { i(1) },
            { delimiters = "<>" }
        )
    ),
    s({trig="@h", dscr="latex eta symbol", snippetType="autosnippet"},
        fmt(
            "\\eta<>",
            { i(1) },
            { delimiters = "<>" }
        )
    ),
    s({trig="@u", dscr="latex theta symbol", snippetType="autosnippet"},
        fmt(
            "\\theta<>",
            { i(1) },
            { delimiters = "<>" }
        )
    ),
    s({trig="@k", dscr="latex kappa symbol", snippetType="autosnippet"},
        fmt(
            "\\kappa<>",
            { i(1) },
            { delimiters = "<>" }
        )
    ),
    s({trig="@l", dscr="latex lambda symbol", snippetType="autosnippet"},
        fmt(
            "\\lambda<>",
            { i(1) },
            { delimiters = "<>" }
        )
    ),
    s({trig="@L", dscr="latex Lambda symbol", snippetType="autosnippet"},
        fmt(
            "\\Lambda<>",
            { i(1) },
            { delimiters = "<>" }
        )
    ),
    s({trig="@m", dscr="latex mu symbol", snippetType="autosnippet"},
        fmt(
            "\\mu<>",
            { i(1) },
            { delimiters = "<>" }
        )
    ),
    s({trig="@n", dscr="latex nu symbol", snippetType="autosnippet"},
        fmt(
            "\\nu<>",
            { i(1) },
            { delimiters = "<>" }
        )
    ),
    s({trig="@x", dscr="latex xi symbol", snippetType="autosnippet"},
        fmt(
            "\\xi<>",
            { i(1) },
            { delimiters = "<>" }
        )
    ),
    s({trig="@p", dscr="latex pi symbol", snippetType="autosnippet"},
        fmt(
            "\\pi<>",
            { i(1) },
            { delimiters = "<>" }
        )
    ),
    s({trig="@P", dscr="latex Pi symbol", snippetType="autosnippet"},
        fmt(
            "\\Pi<>",
            { i(1) },
            { delimiters = "<>" }
        )
    ),
    s({trig="@r", dscr="latex rho symbol", snippetType="autosnippet"},
        fmt( 
            "\\rho<>",
            { i(1) },
            { delimiters = "<>" }
        )
    ),
    s({trig="@s", dscr="latex sigma symbol", snippetType="autosnippet"},
        fmt( 
            "\\sigma<>",
            { i(1) },
            { delimiters = "<>" }
        )
    ),
    s({trig="@S", dscr="latex Sigma symbol", snippetType="autosnippet"},
        fmt( 
            "\\Sigma<>",
            { i(1) },
            { delimiters = "<>" }
        )
    ),
    s({trig="@t", dscr="latex tau symbol", snippetType="autosnippet"},
        fmt(
            "\\tau<>",
            { i(1) },
            { delimiters = "<>" }
        )
    ),
    s({trig="@f", dscr="latex phi symbol", snippetType="autosnippet"},
        fmt( 
            "\\phi<>",
            { i(1) },
            { delimiters = "<>" }
        )
    ),
    s({trig="@F", dscr="latex Phi symbol", snippetType="autosnippet"},
        fmt(
            "\\Phi<>",
            { i(1) },
            { delimiters = "<>" }
        )
    ),
    s({trig="@y", dscr="latex psi symbol", snippetType="autosnippet"},
        fmt(
            "\\psi<>",
            { i(1) },
            { delimiters = "<>" }
        )
    ),
    s({trig="@Y", dscr="latex Psi symbol", snippetType="autosnippet"},
        fmt(
            "\\Psi<>",
            { i(1) },
            { delimiters = "<>" }
        )
    ),
    s({trig="@o", dscr="latex omega symbol", snippetType="autosnippet"},
        fmt(
            "\\omega<>",
            { i(1) },
            { delimiters = "<>" }
        )
    ),
    s({trig="@O", dscr="latex Omega symbol", snippetType="autosnippet"},
        fmt(
            "\\Omega<>",
            { i(1) },
            { delimiters = "<>" }
        )
    ),

    -----------------------------
    --- Accents and Modifiers ---
    -----------------------------
    s({trig="bar", dscr="overline"},
        fmt(
            "\\overline{<>}",
            { i(1) },
            { delimiters = "<>" }
        )
    ),
    s({trig="hat", dscr="hat"},
        fmt(
            "\\hat{<>}",
            { i(1) },
            { delimiters = "<>" }
        )
    ),
    s({trig="dot", dscr="dot"},
        fmt(
            "\\dot{<>}",
            { i(1) },
            { delimiters = "<>" }
        )
    ),
    s({trig="ddot", dscr="ddot"},
        fmt(
            "\\ddot{<>}",
            { i(1) },
            { delimiters = "<>" }
        )
    ),
    s({trig="vec", dscr="vec"},
        fmt(
            "\\vec{<>}",
            { i(1) },
            { delimiters = "<>" }
        )
    ),
    s({trig = '([%a%)%]%}])^', regTrig = true, wordTrig = false, snippetType="autosnippet"},
        fmt(
            "<>^{<>}",
            { f(function(_, snip) return snip.captures[1] end), i(1) },
            { delimiters = "<>" }
        )
    ),
    s({trig = '([%a%)%]%}])_', regTrig = true, wordTrig = false, snippetType="autosnippet"},
        fmt(
            "<>_{<>}",
            { f(function(_, snip) return snip.captures[1] end), i(1) },
            { delimiters = "<>" }
        )
    ),
    s({trig = '([%a%)%]%}])ii', regTrig = true, wordTrig = false, snippetType="autosnippet"},
      fmta(
        "<>_{<>}",
        {
          f( function(_, snip) return snip.captures[1] end ),
          t("i")
        }
      )
    ),
    s({trig = '([%a%)%]%}])jj', regTrig = true, wordTrig = false, snippetType="autosnippet"},
      fmta(
        "<>_{<>}",
        {
          f( function(_, snip) return snip.captures[1] end ),
          t("j")
        }
      )
    ),
    -- s({trig = '([%a%)%]%}])nn', regTrig = true, wordTrig = false, snippetType="autosnippet", priority=100},
    --   fmta(
    --     "<>_{<>}",
    --     {
    --       f( function(_, snip) return snip.captures[1] end ),
    --       t("n")
    --     }
    --   )
    -- ),
    s({trig = '([%a%)%]%}])np1', regTrig = true, wordTrig = false, snippetType="autosnippet"},
      fmta(
        "<>_{<>}",
        {
          f( function(_, snip) return snip.captures[1] end ),
          t("n+1")
        }
      )
    ),
    s({trig = '([%a%)%]%}])00', regTrig = true, wordTrig = false, snippetType="autosnippet"},
      fmta(
        "<>_{<>}",
        {
          f( function(_, snip) return snip.captures[1] end ),
          t("0")
        }
      )
    ),
}

