return function()
	local ReplicatedStorage = game:GetService("ReplicatedStorage")

	local lib = ReplicatedStorage.lib
	local Llama = require(lib.Llama)

	local Dictionary = Llama.Dictionary
	local some = Dictionary.some

	it("should return a boolean", function()
		local function always(bool)
			return function()
				return bool
			end
		end

		expect(some({}, always(true))).to.be.a("boolean")
		expect(some({}, always(false))).to.be.a("boolean")
	end)

	it("should pass the value and key to the predicate", function()
		local a = {
			foo = "bar",
		}

		local function predicate(v, k)
			expect(v).to.equal(a.foo)
			expect(k).to.equal("foo")
		end

		some(a, predicate)
	end)

	it("should return true if at least one entry passes the predicate", function()
		local a = {
			foo = "a",
			baz = "a",
			foobar = "a",
		}

		local function aOnly(v)
			return v == "a"
		end

		expect(some(a, aOnly)).to.equal(true)
	end)

	it("should return false if no entries pass the predicate", function()
		local a = {
			foo = "a",
			baz = "a",
			foobar = "a",
			frob = "b"
		}

		local function cOnly(v)
			return v == "c"
		end

		expect(some(a, cOnly)).to.equal(false)
	end)
end