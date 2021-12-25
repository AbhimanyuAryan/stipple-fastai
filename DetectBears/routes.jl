using Genie, Stipple, StippleUI

#=== config ==#

for m in [Genie, Stipple, StippleUI]
  m.assets_config.host = "https://cdn.statically.io/gh/GenieFramework"
end

# WEB_TRANSPORT = Genie.WebChannels #Genie.WebThreads #

@reactive mutable struct Model <: ReactiveModel
end

#== view ==#
function ui(model)
  page(model, partial = true, [
    heading("Bear Detection Demo")

    row([
      Html.div(class="col-md-12", [
        uploader(label="Upload Image", :auto__upload, :multiple,
        url="http://localhost:4444/upload")
      ])
    ])
    ]
  )
end


#== server ==#

route("/") do
  model = Model |> init

  html(ui(model), context = @__MODULE__)
end

isrunning(:webserver) || up()