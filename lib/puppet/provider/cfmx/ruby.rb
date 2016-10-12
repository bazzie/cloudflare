require 'cloudflare'

Puppet::Type.type(:cfmx).provide(:ruby) do

 def exists?
    begin
      record_exists(resource[:zone], resource[:content])
    rescue Puppet::ExecutionFailure => e
      false
    end
  end    

def create
   cf = CloudFlare::connection(resource[:cf_key], resource[:cf_email])
    zone = resource[:zone]
    type = "MX"
    name = resource[:zone]
    content = resource[:content]
    priority = resource[:priority]
    ttl = 1
    begin
      cf.rec_new(zone, type, name, content, ttl, priority)
    rescue => e 
      p e.message
    end
end

  def destroy
    p "deleting MX record"
  end


def record_exists(zone, content)
    cf = CloudFlare::connection(resource[:cf_key], resource[:cf_email])
    records = cf.rec_load_all(zone)
    x = records['response']['recs']['objs']
    x.each do |record| 
      if record['content'] != "#{content}"
        next
      else
        return true
        break
      end
    end
    return false
  end



end