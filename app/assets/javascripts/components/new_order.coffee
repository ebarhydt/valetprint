@NewOrder = React.createClass
	
	getInitialState:->
		items: []
		customer: {
			name: '',
			address: '',
			address2: '',
			zipcode: '',
			email: '',
			phone: '',
			paymentMethod: 'Choose a payment method'
		}
		loading: {
			document: false,
			orderRequest: false,
		}
		complete: false
		warnings: {
			name: null,
			address: null,
			address2: null,
			zipcode: null,
			email: null,
			phone: null,
			items: null,
		}

	getDeliveryTime: () ->
		today = new Date()
		hours = today.getHours()
		if hours > 11
			daytime = 'pm'
		else
			daytime = 'am'
		if hours > 12
			hours = hours - 12
		hours = hours + 3
		minutes = ('0' + today.getMinutes()).slice(-2)
		hours + ':' + minutes + daytime

	toggleComplete: (e) ->
		e.preventDefault()
		@setState complete: false

	readyToPrint: ->
		c = @state.customer
		c.name && c.email && c.address && c.zipcode && c.phone && @state.items.length > 0

	formChanged: (inputText, inputName) ->
		@state.customer[inputName] = inputText
		@forceUpdate()

	addToOrder: (item) ->
		items = @state.items
		item = {
			document: item.get_filename,
			id: item.id,
			copies: item.copies,
			color: item.color
		}
		items.push item
		@state.items = items
		@forceUpdate()

	updateItem: (item, data) ->
		index = @state.items.indexOf item
		updatedItem = {
			document: data.get_filename,
			id: data.id,
			copies: data.copies,
			color: data.color
		}
		items = @state.items
		items.splice(index, 1, updatedItem)
		@state.items = items
		@forceUpdate()

	deleteItem: (item) ->
		items = @state.items.slice()
		index = items.indexOf item
		items.splice(index, 1)
		@state.items = items
		@forceUpdate()

	validateItems: () ->
		@state.warnings.items = if (@state.items.length > 0) then null else "Add a document before you print"

	validateName: () ->
		@state.warnings.name = if /\S/.test(@state.customer.name) then null else "Tell us your name!"

	validateEmail: () ->
		@state.warnings.email = if /^\w+([\.-]?\w+)*@\w+([\.-]?\w+)*(\.\w{2,3})+$/.test(@state.customer.email) then null else "You're email doesn't look quite right"
		
	validatePhone: () ->
		@state.warnings.phone = if /^\d{10}$/.test(@state.customer.phone) then null else "Phone number needs 10 digits"

	validateAddress: () ->
		@state.warnings.address = if /\S/.test(@state.customer.address) then null else "Tell us where to deliver your order"

	validateZipcode: () ->
		@state.warnings.zipcode = if /^\d{5}(?:[-\s]\d{4})?$/.test(@state.customer.zipcode) then null else "need a valid zipcode"

	formSubmitted: (event) ->
		event.preventDefault()
		@validateItems()
		if !@state.warnings.items
			@validateName()
			@validateEmail()
			@validatePhone()
			@validateAddress()
			@validateZipcode()
		@forceUpdate()
		if @state.warnings.items
			return
		for own key of @state.customer
			return if @state.warnings[key]
		items = @state.items
		c = @state.customer
		itemsarray = []
		for item in items
			itemsarray.push item.id
		$.ajax
			url: "/orders"
			type: "POST"
			dataType: "JSON"
			contentType: "application/json"
			data: JSON.stringify({
				order: {
					address: c.address
					email: c.email
					name: c.name
					address2: c.address2
					phone: c.phone
					zipcode: c.zipcode
					itemsarray: itemsarray
					paymentmethod: c.paymentMethod
				}
			})
			success: (data) =>
				@setState @getInitialState()
				@setState complete: true
			@state.loading.orderRequest = true



	emptyOrder: ->
		return null unless @state.warnings.items
		React.DOM.div
			className: 'text-center empty-order has-warning'
			@state.warnings.items


	orderComplete: ->
		React.DOM.div
			className: 'row'
			React.DOM.div
				className: 'col-sm-4'
				React.DOM.img
					className: 'img-responsive'
					src: '/assets/giphy.gif'
			React.DOM.div
				className: 'col-sm-8'
				React.DOM.h2 null, 'You\'re order is in progress and will arrive by ' + @getDeliveryTime()
				React.DOM.div null,
					'You will receive an email confirmation shortly. If you have any questions, please feel free to email Ethan Barhydt at ethan@valetprint.com or call/text 847-494-2629.'
				React.DOM.a
					className: 'btn btn-primary'
					onClick: @toggleComplete
					'Create a new order'

	orderInProgress: ->
		React.DOM.div null,
			React.DOM.div
				className: 'col-md-8 order'
				React.DOM.h2 null, 'Place an order'
				
				React.createElement NewDocument,
					handleNewDocument: @addToOrder,
					handleLoading: @toggleLoading
					validFile: @state.validFile
					warning: @state.warnings.noFile
				
				React.DOM.div
					className: 'current-order section'
					React.DOM.span null, 'Documents currently in your order (' + @state.items.length + ')'
					React.DOM.div
						className: 'documents'
						unless @state.items.length == 0
							React.DOM.table null,
								React.DOM.tbody null,
									for item in @state.items
										React.createElement Document, item: item, key: item.id, handleDeleteItem: @deleteItem, handleEditItem: @updateItem
						else
							@emptyOrder()
			React.DOM.div
				className: 'checkout col-md-4'
				React.createElement CheckoutForm,
					customer: @state.customer
					items: @state.items
					onChange: @formChanged
					validatePrinter: @readyToPrint()
					onSubmit: @formSubmitted
					warnings: @state.warnings
					loading: @state.loading.orderRequest
	render: ->
		if @state.complete
			@orderComplete()
		else
			@orderInProgress()

