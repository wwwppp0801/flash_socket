package
{
    import flash.desktop.NativeApplication;
    import flash.display.Sprite;
    import flash.events.DNSResolverEvent;
    import flash.events.ErrorEvent;
    import flash.events.Event;
    import flash.events.MouseEvent;
    import flash.net.dns.AAAARecord;
    import flash.net.dns.ARecord;
    import flash.net.dns.DNSResolver;
    import flash.net.dns.MXRecord;
    import flash.net.dns.PTRRecord;
    import flash.net.dns.SRVRecord;
    import flash.utils.getQualifiedClassName;
    
    public class DNSResolverExample extends Sprite
    {
        private var resolver:DNSResolver = new DNSResolver();
        
        public function DNSResolverExample()
        {
            resolver.addEventListener( DNSResolverEvent.LOOKUP, lookupComplete );
            resolver.addEventListener( ErrorEvent.ERROR, lookupError );
            
            //Look up records
            resolver.lookup( "www.example.com", ARecord );
            resolver.lookup( "example.com", AAAARecord );
            resolver.lookup( "example.com", MXRecord );
            resolver.lookup( "208.77.188.166", PTRRecord );
            resolver.lookup( "127.0.0.1", PTRRecord );
            resolver.lookup( "2001:1890:110b:1e19:f06b:72db:7026:3d7a", PTRRecord );
            resolver.lookup( "_sip._tcp.example.com.", SRVRecord );
            resolver.lookup( "www.example.com", ARecord );
            
            this.stage.nativeWindow.activate();
        }
        
        private function lookupComplete( event:DNSResolverEvent ):void
        {
            trace( "Query string: " + event.host );
            trace( "Record type: " +  flash.utils.getQualifiedClassName( event.resourceRecords[0] ) + 
                ", count: " + event.resourceRecords.length );
            for each( var record in event.resourceRecords )
            {
                if( record is ARecord ) trace( record.name + " : " + record.address );
                if( record is AAAARecord ) trace( record.name + " : " + record.address );
                if( record is MXRecord ) trace( record.name + " : " + record.exchange + ", " + record.preference );
                if( record is PTRRecord ) trace( record.name + " : " + record.ptrdName );
                if( record is SRVRecord ) trace( record.name + " : " + record.target + ", " + record.port +
                    ", " + record.priority + ", " + record.weight );
            }            
        }
        
        private function lookupError( error:ErrorEvent ):void
        {
            trace("Error: " + error.text );
        }
    }
}
