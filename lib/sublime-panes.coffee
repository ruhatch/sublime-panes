SublimePanesView = require './sublime-panes-view'
{CompositeDisposable} = require 'atom'

module.exports = SublimePanes =
  sublimePanesView: null
  modalPanel: null
  subscriptions: null

  activate: (state) ->
    @sublimePanesView = new SublimePanesView(state.sublimePanesViewState)
    @modalPanel = atom.workspace.addModalPanel(item: @sublimePanesView.getElement(), visible: false)

    # Events subscribed to in atom's system can be easily cleaned up with a CompositeDisposable
    @subscriptions = new CompositeDisposable

    # Register command that toggles this view
    @subscriptions.add atom.commands.add 'atom-workspace', 'sublime-panes:toggle': => @toggle()

  deactivate: ->
    @modalPanel.destroy()
    @subscriptions.dispose()
    @sublimePanesView.destroy()

  serialize: ->
    sublimePanesViewState: @sublimePanesView.serialize()

  toggle: ->
    console.log 'SublimePanes was toggled!'

    if @modalPanel.isVisible()
      @modalPanel.hide()
    else
      @modalPanel.show()
