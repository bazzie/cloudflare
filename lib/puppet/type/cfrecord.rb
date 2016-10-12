Puppet::Type.newtype(:cfrecord) do
  ensurable

  #validate do
  #  fail('Use type \'cfmx\' for MX records') if self[:type] == :MX
  #end 

  newparam(:name, :namevar => true) do
  end

  newparam(:zone) do
  end

  newparam(:type) do
    defaultto(:A)
    newvalues(:A, :AAAA, :CNAME, :MX, :SRV, :TXT, :PTR)
  end

  newparam(:content) do
  end
 
  newparam(:priority) do
  end

  newparam(:cf_key) do
  end

  newparam(:cf_email) do
  end

end