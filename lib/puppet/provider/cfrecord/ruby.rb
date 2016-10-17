require 'cloudflare' if Puppet.features.cloudflare?


Puppet::Type.type(:cfrecord).provide(:ruby) do

  confine :feature => :cloudflare

  def exists?
    begin
      record_exists(resource[:zone], resource[:name])
    rescue Puppet::ExecutionFailure => e
      false
    end
  end    

  def create
    cf = CloudFlare::connection(resource[:cf_key], resource[:cf_email])
    zone = resource[:zone]
    type = resource[:type]
    name = resource[:name]
    content = resource[:content]
    begin
      cf.rec_new(zone, type, name, content, 1)
    rescue => e 
      p e.message
    else
      p "Sucessfully added record #{name}.#{zone}"
    end
  end

  def destroy
    record_delete(resource[:zone], resource[:name])
  end


  def record_exists(zone, name)
    cf = CloudFlare::connection(resource[:cf_key], resource[:cf_email])
    records = cf.rec_load_all(zone)
    x = records['response']['recs']['objs']
    x.each do |record|
      if record['display_name'] != name
        next
      else
        return true
        break
      end
    end
    return false
  end

  def record_delete(zone, name)
    cf = CloudFlare::connection(resource[:cf_key], resource[:cf_email])
    records = cf.rec_load_all(zone)
    x = records['response']['recs']['objs']
    x.each do |record| 
      if record['display_name'] == name
        zoneid = record['rec_id']
        cf.rec_delete(zone, zoneid)
      end
    end
  end

end