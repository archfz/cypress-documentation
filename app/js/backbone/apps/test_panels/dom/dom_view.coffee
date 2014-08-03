@App.module "TestPanelsApp.DOM", (DOM, App, Backbone, Marionette, $, _) ->

  class DOM.Layout extends App.Views.LayoutView
    template: "test_panels/dom/layout"

  class DOM.Dom extends App.Views.ItemView
    template: "test_panels/dom/_dom"

    ui:
      meta:     ".meta-container"
      icon:     ".content-icon i"
      selector: ".content-selector-container"
      close:    ".fa-times"

    events:
      "click @ui.meta"     : "metaClicked"
      "click @ui.selector" : "selectorClicked"
      "click @ui.close"    : "closeClicked"

    modelEvents:
      "change:chosen" : "render"

    onShow: ->
      @$el.addClass "error" if @model.get("error")

    onRender: ->
      klass = if @model.isChosen() then "down" else "right"
      @ui.icon.removeClass().addClass("fa fa-chevron-#{klass}")

    selectorClicked: (e) ->
      e.stopPropagation()
      console.info "DOM: ", @model.el

    metaClicked: (e) ->
      @model.toggleChoose()

    closeClicked: (e) ->
      @model.unchoose()

  class DOM.Doms extends App.Views.CollectionView
    tagName: "ul"
    childView: DOM.Dom