@NewDocument = React.createClass

	getInitialState: ->
		validFile: false
		color: false
		radioActive: 'B&W'
		validCopies: true
		copies: 1
		filename: ''

	newDocumentChanged: (event) ->
		@state.validFile = true
		@state.filename = event.target.value
		@state.document = event.target.value
		@forceUpdate()

	handleAddToOrder: (e) ->
		e.preventDefault()
		alert "done"

	handleSubmit: (event) ->
		formData = new FormData()
		formData.append 'item[document]', @refs.file.getDOMNode().files[0]
		formData.append 'item[copies]', @state.copies
		formData.append 'item[color]', @state.color
		$.ajax
			url: '/items'
			data: formData
			contentType: false
			processData: false
			type: 'POST'
			success: (data) => 
				React.findDOMNode(@refs.file).value = ""
				@setState @getInitialState()
				@props.handleNewDocument data
		event.preventDefault()

	handleChange: (event) ->
		name = event.target.name
		@setState "#{ name }": event.target.value
		alert @state.copies

	handleColorChange: (event) ->
		unless event.target.textContent == @state.radioActive
			@setState radioActive: event.target.textContent
			@setState color: !@state.color

	valid: ->
		@state.validFile && @state.validCopies

	render: ->
		React.DOM.div
			className: 'upload section'
			React.DOM.span null, 'Choose a document you\'d like to print'
			React.DOM.form
				className: 'form-inline'
				onSubmit: @handleSubmit

				React.DOM.div
					className: 'form-group'
					React.DOM.span
						className: 'btn btn-primary btn-file'
						'Browse'
						React.DOM.input
							ref: 'file'
							type: 'file'
							className: 'form-control'
							placeholder: 'Document'
							name: 'document'
							onChange: @newDocumentChanged
					React.DOM.input
						type: "text"
						readOnly: true
						placeholder: 'filename'
						value: @state.filename.replace(/^.*[\\\/]/, '')
						className: 'form-control'
				
				React.DOM.div
					className: 'form-group radio-buttons btn-group'
					"data-toggle": "buttons"
					React.DOM.label
						className: 'btn btn-default active'
						onClick: @handleColorChange
						React.DOM.input
							type: 'radio'
							className: 'form-control'
							name: 'color'
							value: 'B&W'
							defaultChecked: true
						'B&W'
					React.DOM.label
						className: 'btn btn-default'
						onClick: @handleColorChange
						React.DOM.input
							type: 'radio'
							className: 'form-control'
							name: 'color'
							value: 'color'
						'Color'

				React.DOM.div
					className: 'form-group input-number'
					'Copies'
					React.DOM.input
						type: 'number'
						className: 'form-control'
						name: 'copies'
						value: @state.copies
						min: '1'
						onChange: @handleChange
				React.DOM.button
					type: 'submit'
					className: 'btn btn-default pull-right'
					disabled: !@valid()
					'Add to order'












