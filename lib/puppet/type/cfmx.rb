Puppet::Type.newtype(:cfmx) do
  ensurable

  #validate do
  ##  fail(‘priority is required for MX records’) if self[:priority].nil?
  #end 

  newparam(:zone) do
  end

  newparam(:type) do
    defaultto(:MX)
  end

  newparam(:content, :namevar => true) do
  end
 
  newparam(:priority) do
  end

  newparam(:cf_key) do
  end

  newparam(:cf_email) do
  end

end