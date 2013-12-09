require "spec_helper"

describe GarmentsController do
  describe "routing" do

    it "routes to #index" do
      get("/garments").should route_to("garments#index")
    end

    it "routes to #new" do
      get("/garments/new").should route_to("garments#new")
    end

    it "routes to #show" do
      get("/garments/1").should route_to("garments#show", :id => "1")
    end

    it "routes to #edit" do
      get("/garments/1/edit").should route_to("garments#edit", :id => "1")
    end

    it "routes to #create" do
      post("/garments").should route_to("garments#create")
    end

    it "routes to #update" do
      put("/garments/1").should route_to("garments#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/garments/1").should route_to("garments#destroy", :id => "1")
    end

  end
end
