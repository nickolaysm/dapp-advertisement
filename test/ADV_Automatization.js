var ADV_Automatization = artifacts.require("./adv/ADV_Automatization.sol");
var MyAdvancedToken = artifacts.require("./adv/MyAdvancedToken.sol");

contract('ADV_Automatization', function(accounts) {
	const tokenOwner   = accounts[1];	
	const adv_owner    = accounts[2];
	const token_sender = accounts[3]; 

	const ADV_TEXT   = "Some adv text";

    it("...test advetisement contract.", async () => {
    	let mytoken = await MyAdvancedToken.new(1000, "Adv Token Test", "AdTT", { from: tokenOwner });

		console.log("+++ before transfer", token_sender);
    	await mytoken.transfer(token_sender, 900, { from: tokenOwner });

		let adv     = await ADV_Automatization.new(mytoken.address, { from: adv_owner});

		var balance = await mytoken.getBalance1(token_sender);
		console.log("+++ token_sender, balance", token_sender, balance);

		await mytoken.approveAndCallAdv(adv.address, 100, ADV_TEXT, "", 0, { from: token_sender });

		var balance = await mytoken.getBalance1(token_sender);
		console.log("+++ token_sender, balance after order", token_sender, balance);


		// const advText = await adv.getAdvertisementAdvText(0)
		// console.log("+++ advText",advText);
		// assert.equal(advText, ADV_TEXT, "adv text is not same");

		const advTupple = await adv.getAdvertisement(0);
		console.log("+++ advAddr",advTupple);
		assert.equal(advTupple[0], token_sender, "address in contract should be like a token_sender");
    });

});
