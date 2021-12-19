(pwd() != @__DIR__) && cd(@__DIR__) # allow starting app from bin/ dir

using DetectBears
push!(Base.modules_warned_for, Base.PkgId(DetectBears))
DetectBears.main()
