AtomSvgIconSnippetsView = require './atom-svg-icon-snippets-view'
{CompositeDisposable} = require 'atom'

module.exports = AtomSvgIconSnippets =
  atomSvgIconSnippetsView: null
  modalPanel: null
  subscriptions: null

  activate: (state) ->
    @atomSvgIconSnippetsView = new AtomSvgIconSnippetsView(state.atomSvgIconSnippetsViewState)
    @modalPanel = atom.workspace.addModalPanel(item: @atomSvgIconSnippetsView.getElement(), visible: false)

    # Events subscribed to in atom's system can be easily cleaned up with a CompositeDisposable
    @subscriptions = new CompositeDisposable

    # Register command that toggles this view
    @subscriptions.add atom.commands.add 'atom-workspace', 'atom-svg-icon-snippets:toggle': => @toggle()

  deactivate: ->
    @modalPanel.destroy()
    @subscriptions.dispose()
    @atomSvgIconSnippetsView.destroy()

  serialize: ->
    atomSvgIconSnippetsViewState: @atomSvgIconSnippetsView.serialize()

  toggle: ->
    console.log 'AtomSvgIconSnippets was toggled!'

    if @modalPanel.isVisible()
      @modalPanel.hide()
    else
      @modalPanel.show()
