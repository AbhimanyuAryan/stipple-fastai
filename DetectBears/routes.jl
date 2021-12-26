using Genie, Stipple, StippleUI
using Genie.Requests, Genie.Renderer
using FastAI, FileIO, DLPipelines

Genie.config.cors_headers["Access-Control-Allow-Origin"]  =  "*"
Genie.config.cors_headers["Access-Control-Allow-Headers"] = "Content-Type"
Genie.config.cors_headers["Access-Control-Allow-Methods"] = "GET,POST,PUT,DELETE,OPTIONS"
Genie.config.cors_allowed_origins = ["*"]

const FILE_PATH = "upload/file.jpg"

@reactive mutable struct Model <: ReactiveModel
end

#== view ==#
function ui(model)
  page(model, partial = true, [
    heading("Bear Detection Demo")

    row([
      Html.div(class="col-md-12", [
        uploader(label="Upload Image", :auto__upload, :multiple, method="POST",
        url="http://localhost:8000/upload", field__name="img")
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

route("/upload", method = POST) do
  if infilespayload(:img)
    @info filename(filespayload(:img))
    @info filespayload(:img).data

    open(FILE_PATH, "w") do io
      write(FILE_PATH, filespayload(:img).data)
    end
  else
    @info "No image uploaded"
  end

  Genie.Renderer.redirect(:get)
end

route("/predict") do
  @info DLPipelines.predict(load(FILE_PATH), "imgnet.jld2")
end

isrunning(:webserver) || up()