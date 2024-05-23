use Benchmark qw(:all);
#my $lead_module;
# my $t0 = Benchmark->new;
# $lead_module = MA::Insurance::Lead::Health::USHA_Generic_NexBid_PP->new();
# for (1..1000000) {    
#     $lead_module->matched_reject_err_msg("Lead () sent outside of the distribution's (52389ac1-0c63-4c5a-a303-5ecdce455eb3) schedule");
# }
# my $t1 = Benchmark->new;
# $lead_module = MA::Insurance::Lead::Health::USHA_Generic_NexBid_PP->new();
# for (1..1000000) {
#     $lead_module->matched_reject_err_msg_array("Lead () sent outside of the distribution's (52389ac1-0c63-4c5a-a303-5ecdce455eb3) schedule");    
# }

# my $td = timediff($t1, $t0);
# print(timestr($td));
my $lead_module = MA::Insurance::Lead::Health::USHA_Generic_NexBid_PP->new();
cmpthese(-5, {
    'array' => sub {
        #my $lead_module = MA::Insurance::Lead::Health::USHA_Generic_NexBid_PP->new();
        $lead_module->matched_reject_err_msg_array("Lead () sent outside of the distribution's (52389ac1-0c63-4c5a-a303-5ecdce455eb3) schedule");        
    },
    'hash' => sub {
        #my $lead_module = MA::Insurance::Lead::Health::USHA_Generic_NexBid_PP->new();
        $lead_module->matched_reject_err_msg("Lead () sent outside of the distribution's (52389ac1-0c63-4c5a-a303-5ecdce455eb3) schedule");
    }
}
);