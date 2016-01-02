@OrderForm = React.createClass
	getInitialState:->
		address: ''

	handleAppendItemForm: (e)->
		e.preventDefault()
		$('.order-form').append(React.renderComponent ItemForm)

	render:->
		React.DOM.div
			className: 'order-form'
			React.DOM.h3
				className: 'order-form-title'
				'Start of Order Form'
			React.createElement ItemForm
			React.DOM.a
				onClick: @handleAppendItemForm
				className: 'new-item-form'
				'Add another item'