@FormInputWithLabel = React.createClass

	getDefaultProps: -> 
		elementType: "input"
		inputType: "text"

	displayName: "FormInputWithLabel"

	render: ->
		React.DOM.div
			className: 'form-group' + {true: ' has-warning', false: ''}[!!@props.warning]
			@warning()
			React.DOM[@props.elementType]
				className: 'form-control'
				placeholder: @props.placeholder
				id: @props.id
				name: @props.name
				defaultValuealue: @props.defaultValue
				onChange: @props.onChange
				type: @tagType()
	tagType: ->
		{
			"input": @props.inputType,
			"textarea": null,
		}[@props.elementType]

	warning: ->
		return null unless @props.warning
		React.DOM.label
			className: 'control-label'
			htmlFor: @props.id
			@props.warning