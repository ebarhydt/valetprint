@ItemForm = React.createClass
	getInitialState:->
		document: ''
		pages: ''
		price: ''

	valid:->
		@state.document

	handleChange:(e)->
		name = e.target.name
		@setState "#{ name }": e.target.value

	render: ->
		React.DOM.form
			className: 'form-inline'

			React.DOM.div
				className: 'form-group'
				React.DOM.input
					type: 'file'
					className: 'form-control'
					placeholder: 'Document'
					name: 'document'
					value: @state.document
					onChange: @handleChange
