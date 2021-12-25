using Genie, Stipple, StippleUI


#== view ==#
function ui(model)
  page(
    prepend = """
    <style>
      .rb {
        border-right: 10pt solid #fff;
      }
    </style>
    """,

    vm(model), class="container", [
      heading("Detect Bear Type AI")

      row([
        cell([
          p(button("Reverse"))
        ])
      ])
    ]
  )
end

#== server ==#

route("/") do
  mode = Model |> init
end