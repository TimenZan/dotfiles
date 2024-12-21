return {
    s("trig", t("loaded")),
    s("dnd spell", 
        fmta(
            [[
                \section*{<>}

                \textit{<>-level <>}
                \begin{description}
                    \item[Casting Time:] <>
                    \item[Range:] <>
                    \item[Components:] <>
                    \item[Duration:] <>
                \end{description}

                <>

                \textbf{\textit{Higher Levels.}} <>
            ]],
            {
                i(1),
                i(2),
                i(3),
                i(4),
                i(5),
                i(6),
                i(7),
                i(8),
                i(9),
            }
            -- { delimiters = "<>" }
        )
    ),
}

