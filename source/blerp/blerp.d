
/**
 * Module to replace the built-in unit tester.
 *
 * License:
 *     MIT. See LICENSE for full details.
 */
module blerp.blerp;

/**
 * Imports.
 */
import core.exception;
import core.runtime;

import blerp.results;
import blerp.console;

/**
 * Replace the standard unit test handler.
 */
version(unittest) shared static this()
{
	Runtime.moduleUnitTester = function()
	{
		auto console = new Console();
		auto results = new Results();

		console.writeHeader();

		foreach (module_; ModuleInfo)
		{
			if (module_)
			{
				auto unitTest = module_.unitTest;

				if (unitTest)
				{
					try
					{
						unitTest();
					}
					catch (AssertError ex)
					{
						results.add(new Result(module_.name, new AssertError(ex.msg, ex.file, ex.line)));
						continue;
					}
					results.add(new Result(module_.name));
				}
			}
		}

		console.writeReport(results);

		return !results.failedCount();
	};
}
