@CheckoutForm = React.createClass

	getInitialState: ->
		loading: @props.loading


	loadingGif: ->
		if @props.loading
			React.DOM.img
				src: "/assets/ajax-loader.gif"

	render: -> 
		React.DOM.h2
			className: 'text-center'
			'Checkout'
		React.DOM.div
			className: 'cost'
			React.DOM.div
				className: 'order-info'
				React.DOM.b null,
					'Documents to print: '
				@props.items.length
			React.DOM.div
				className: 'order-info'
				React.DOM.b null,
					'Price: '
				'$10.00 (delivery included)'
				React.DOM.div
					className: 'notice'
					'Please note: for the beta trial, we are charging a flat rate of $10 for up to 50 pages of printing so that you can try out the service at low cost. Out of beta, there will be a per-page fee + delivery fee.'
			React.DOM.form
				onSubmit: @props.onSubmit
				React.createElement FormInputWithLabel,
					name: 'name'
					placeholder: 'Name'
					defaultValue: @props.customer.name
					onChange: (event) =>
						@props.onChange(event.target.value, event.target.name)
					warning: @props.warnings.name
				React.createElement FormInputWithLabel,
					name: 'email'
					placeholder: 'Email'
					defaultValue: @props.customer.name
					onChange: (event) =>
						@props.onChange(event.target.value, event.target.name)
					warning: @props.warnings.email
				React.createElement FormInputWithLabel,
					name: 'phone'
					placeholder: 'Phone'
					defaultValue: @props.customer.name
					onChange: (event) =>
						@props.onChange(event.target.value, event.target.name)
					warning: @props.warnings.phone
				React.createElement FormInputWithLabel,
					name: 'address'
					placeholder: 'Address'
					defaultValue: @props.customer.name
					onChange: (event) =>
						@props.onChange(event.target.value, event.target.name)
					warning: @props.warnings.address
				React.createElement FormInputWithLabel,
					name: 'address2'
					placeholder: 'Floor or apt #'
					defaultValue: @props.customer.name
					onChange: (event) =>
						@props.onChange(event.target.value, event.target.name)
					warning: @props.warnings.address2
				React.createElement FormInputWithLabel,
					name: 'zipcode'
					placeholder: 'Zipcode'
					defaultValue: @props.customer.name
					onChange: (event) =>
						@props.onChange(event.target.value, event.target.name)
					warning: @props.warnings.zipcode
				React.DOM.div
					className: 'form-group'
					React.DOM.select 
						className: 'form-control'
						name: 'paymentMethod'
						value: @props.customer.paymentMethod
						onChange: (event) =>
							@props.onChange(event.target.value, event.target.name)
						React.DOM.option(value: "placeholder", "Choose a payment method")
						React.DOM.option(value: paymethod, key: paymethod, paymethod) for paymethod in ["Pay cash on delivery", "Paypal (we'll send email instructions)", "Venmo (we'll send email instructions)"]

				React.DOM.div
					className: 'text-center'
					React.DOM.button
						className: 'btn btn-success btn-print text-center'
						type: "submit"
						React.DOM.h2 
							className: 'text-center'
							'Print'






