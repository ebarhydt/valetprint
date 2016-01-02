@Document = React.createClass

	getInitialState: ->
		edit: false

	handleToggle: (e) ->
		e.preventDefault()
		@setState edit: !@state.edit

	handleEdit: (e) ->
		e.preventDefault()
		data =
			color: React.findDOMNode(@refs.color).checked
			copies: React.findDOMNode(@refs.copies).value
		$.ajax
			method: 'PUT'
			url: "/items/#{ @props.item.id }"
			dataType: 'JSON'
			data:
				item: data
			success: (data) =>
				@setState edit: false
				@props.handleEditItem @props.item, data

	handleDelete: (e) ->
		e.preventDefault()
		$.ajax
			method: 'DELETE'
			url: "/items/#{ @props.item.id }"
			dataType: 'JSON'
			success: () =>
				@props.handleDeleteItem @props.item

	documentForm: ->
		React.DOM.tr null,
			React.DOM.td null, @props.item.document
			React.DOM.td 
				className: 'form-group radio-buttons btn-group'
				"data-toggle": "buttons"
				React.DOM.label
					className: 'btn btn-default ' + ('active' if !@props.item.color)
					React.DOM.input
						type: 'radio'
						className: 'form-control'
						name: 'color'
						ref: 'b&w'
						value: 'B&W'
					'B&W'
				React.DOM.label
					className: 'btn btn-default ' + ('active' if @props.item.color)
					React.DOM.input
						type: 'radio'
						defaultChecked: @props.item.color
						className: 'form-control'
						name: 'color'
						ref: 'color'
						value: 'color'
					'Color'
			React.DOM.td
				className: 'form-group'
				React.DOM.input
					type: 'number'
					className: 'form-control'
					name: 'copies'
					defaultValue: @props.item.copies
					min: '1'
					ref: 'copies'
			React.DOM.td
				React.DOM.a
					className: 'btn btn-danger'
					onClick: @handleToggle
					'Cancel'
			React.DOM.td
				React.DOM.a
					className: 'btn btn-default'
					onClick: @handleEdit
					'Update'

	documentRow: ->
		React.DOM.tr null,
			React.DOM.td null, @props.item.document
			React.DOM.td null,
				if @props.item.color
					'Print in color'
				else
					'Print in black & white'
			React.DOM.td null,
				'Copies: ' + @props.item.copies
			React.DOM.td null,
				React.DOM.a
					className: 'btn btn-primary'
					onClick: @handleToggle
					'Edit'
			React.DOM.td null,
				React.DOM.a
					className: 'btn btn-danger'
					onClick: @handleDelete
					'Remove'

	
	render: ->
		if @state.edit
			@documentForm()
		else
			@documentRow()

