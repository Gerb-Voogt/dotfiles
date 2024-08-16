return {
    ----------------------
    --- Other Snippets ---
    ----------------------
    s({trig="__main__", dscr="Insert an if main"},
        fmt(
            [[
              if __name__ == "__main__":
                main()
            ]], { }, { }
        )
    ),
    s({trig="__docstring__", dscr="Insert a docstring template"},
        fmt(
            [[
            """
            description

            Parameters
            ----------
            
            Return
            ------
            """
            ]], { }, { }
        )
    ),
}

