using System.Text;
using System.Collections;

namespace System.Diagnostics
{
	class ProcessStartInfo
	{
		bool mUseShellExecute = true;
		bool mRedirectStandardInput = false;
		bool mRedirectStandardOutput = false;       
		bool mRedirectStandardError = false;
		bool mCreateNoWindow = false;
		bool mActivateWindow = false;
		public bool ErrorDialog;
		//public Windows.Handle ErrorDialogParentHandle;
		//public ProcessWindowStyle WindowStyle;

		String mFileName = new String() ~ delete _;
		String mArguments = new String() ~ delete _;
		String mDirectory = new String() ~ delete _;
		String mVerb = new String("Open") ~ delete _;

		public Dictionary<String, String> mEnvironmentVariables ~ DeleteDictionaryAndKeysAndValues!(_); 

		public bool UseShellExecute { get { return mUseShellExecute; } set { mUseShellExecute = value; } };
		public bool RedirectStandardInput { get { return mRedirectStandardInput; } set { mRedirectStandardInput = value; } };
		public bool RedirectStandardOutput { get { return mRedirectStandardOutput; } set { mRedirectStandardOutput = value; } };
		public bool RedirectStandardError { get { return mRedirectStandardError; } set { mRedirectStandardError = value; } };
		public bool CreateNoWindow { get { return mCreateNoWindow; } set { mCreateNoWindow = value; } };
		public bool ActivateWindow { get { return mActivateWindow; } set { mActivateWindow = value; } };

		Encoding StandardOutputEncoding;
		Encoding StandardErrorEncoding;

		//public bool redirectStandardInput { get { return redirectStandardInput; } set { redirectStandardInput = value; } };
		//public bool redirectStandardInput { get { return redirectStandardInput; } set { redirectStandardInput = value; } };

		public void GetFileName(String outFileName)
		{
			if (mFileName != null)
				outFileName.Append(mFileName);
		}

		public void SetFileNameAndArguments(StringView string)
		{
			if (string.StartsWith('"'))
			{
				int endPos = string.IndexOf('"', 1);
				if (endPos != -1)
				{
					SetFileName(.(string, 1, endPos - 1));
					SetArguments(.(string, endPos + 2));
					return;
				}
			}

			int spacePos = string.IndexOf(' ');
			if (spacePos != -1)
			{
				SetFileName(.(string, 0, spacePos));
				SetArguments(.(string, spacePos + 1));
				return;
			}

			SetFileName(string);
		}

		public void SetFileName(StringView fileName)
		{
			mFileName.Set(fileName);
		}
		
		public void SetWorkingDirectory(StringView fileName)
		{
			mDirectory.Set(fileName);
		}

		public void SetArguments(StringView arguments)
		{
			mArguments.Set(arguments);
		}

		public void SetVerb(StringView verb)
		{
			mVerb.Set(verb);
		}

		public void AddEnvironmentVariable(StringView key, StringView value)
		{
			if (mEnvironmentVariables == null)
			{
                mEnvironmentVariables = new Dictionary<String, String>();
				Environment.GetEnvironmentVariables(mEnvironmentVariables);
			}

			Environment.SetEnvironmentVariable(mEnvironmentVariables, key, value);
		}

		public this()
		{
			//Debug.WriteLine("ProcStartInfo {0} Verb: {1} Tick: {2}", this, mVerb, (int32)Platform.BfpSystem_TickCount());
		}

		public this(Process process)
		{

		}
	}
}
