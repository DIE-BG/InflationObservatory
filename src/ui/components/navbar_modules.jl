"""
    navbar_modules(;title::String, sections::Vector{Pair{String, String}})
Create a secondary navbar component with a title and sections.
## # Arguments
- `title::String`: The title to display on the navbar.
- `sections::Vector{Pair{String, String}}`: A vector of pairs where each
    pair consists of an anchor ID and the display name for the section.
"""
function navbar_modules(;title::String, sections::Vector{Pair{String, String}}) 

    sections = Genie.Renderers.Html.for_each(x ->
        """
        <li>
            <a
            href="#$(x.first)"
            class="px-3 py-1 rounded-md text-[#00457f]/55 hover:text-[#00457f]
                    hover:bg-slate-100/80 transition"
            >
            $(x.second)
            </a>
        </li>\n
        """,
       sections 
    )

    return """
        <!-- Navbar secundario (sin resaltado automático) -->
        <header
        class="sticky top-16 z-40 w-full bg-white/90 backdrop-blur border-b border-slate-200
                shadow-[0_8px_20px_-12px_rgba(0,0,0,0.35)]"
        >
        <nav class="mx-auto max-w-6xl px-6">
            <div class="h-11 flex items-center justify-center">
                <div class="flex items-center gap-6 text-xs font-medium">
                    <!-- Nombre: normal, más oscuro -->
                    <div class="text-[#00457f]/85 tracking-wide">
                    $title
                    </div>

                    <!-- Separador vertical -->
                    <div class="h-4 w-px bg-slate-300/80"></div>

                    <!-- Links -->
                    <ul class="flex items-center gap-2">
                    
                    $sections

                    </ul>
                </div>
            </div>
        </nav>
        </header>
    """
end 