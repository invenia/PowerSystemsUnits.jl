using Documenter, PowerSystemsUnits

makedocs(;
    modules=[PowerSystemsUnits],
    format=:html,
    pages=[
        "Home" => "index.md",
    ],
    repo="https://github.com/invenia/PowerSystemsUnits.jl/blob/{commit}{path}#L{line}",
    sitename="PowerSystemsUnits.jl",
    authors="Invenia Technical Computing Corporation",
    assets=[
        "assets/invenia.css",
        "assets/logo.png",
    ],
)

deploydocs(;
    repo="github.com/invenia/PowerSystemsUnits.jl",
    target="build",
    julia="0.6",
    deps=nothing,
    make=nothing,
)
