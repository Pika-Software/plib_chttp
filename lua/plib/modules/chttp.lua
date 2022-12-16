local client = HTTP

if pcall( require, 'chttp' ) and (CHTTP ~= nil) then
	client = CHTTP
elseif pcall( require, 'reqwest' ) and (reqwest ~= nil) then
	client = reqwest
else
	plib.Warn( 'Couldn\'t load http client, you probably didn\'t download it,\nI highly recommend to install one of these binnary modules.\nchttp: https://github.com/timschumi/gmod-chttp/releases\nreqwest: https://github.com/WilliamVenner/gmsv_reqwest/releases' )
	return
end

local isfunction = isfunction
local ArgAssert = ArgAssert
local isstring = isstring

function http.Fetch( url, onSuccess, onFailure, headers, timeout )
	ArgAssert( url, 1, 'string' )

	client({
		['url'] = url,
		['method'] = 'GET',
		['failed'] = onFailure,
		['success'] = function( code, body, headers )
			if isfunction( onSuccess ) then
				onSuccess( body, isstring( body ) and #body or 0, headers, code )
			end
		end,
		['timeout'] = timeout,
		['headers'] = headers
	})
end

function http.Post( url, parameters, onSuccess, onFailure, headers, timeout )
	ArgAssert( url, 1, 'string' )

	client({
		['url'] = url,
		['method'] = 'POST',
		['failed'] = onFailure,
		['success'] = function( code, body, headers )
			if isfunction( onSuccess ) then
				onSuccess( body, isstring( body ) and #body or 0, headers, code )
			end
		end,
		['timeout'] = timeout,
		['parameters'] = parameters,
		['headers'] = headers
	})
end