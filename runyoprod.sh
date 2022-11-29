asetup Athena,21.0.130,here

Sim_tf.py  \
  --inputEVNTFile "dsid_Gtt_2200_200_0p01ns.EVNT.pool.root" \
 --geometryVersion="default:ATLAS-R2-2016-01-00-01" \
 --DBRelease="all:current" \
 --conditionsTag "default:OFLCOND-MC16-SDR-RUN2-09" \
 --postInclude "default:RecJobTransforms/UseFrontier.py" \
 --preExec "EVNTtoHITS:simFlags.SimBarcodeOffset.set_Value_and_Lock(200000)" "EVNTtoHITS:simFlags.TRTRangeCut=30.0;simFlags.TightMuonStepping=True" \
 --preInclude "EVNTtoHITS:SimulationJobOptions/preInclude.BeamPipeKill.py,SimulationJobOptions/preInclude.FrozenShowersFCalOnly.py" \
 --outputHITSFile "g4hits.pool.root" \
 --physicsList=FTFP_BERT_ATL_VALIDATION  \
 --maxEvents="10" \
 --randomSeed="8" \
 --simulator="FullG4_LongLived" \
 --truthStrategy=MC15aPlus


asetup Athena,22.0.41.5,here
Digi_tf.py \
--athenaMPEventsBeforeFork=1 \
--conditionsTag "default:OFLCOND-MC16-SDR-RUN2-09" \
--digiSteeringConf=StandardSignalOnlyTruth \
--geometryVersion="default:ATLAS-R2-2016-01-00-01" \
--multiprocess=True \
--PileUpPresampling=False \
--postInclude "default:PyJobTransforms/UseFrontier.py" \
--preInclude "HITtoRDO:Campaigns/MC20a.py" \
--inputHITSFile "g4hits.pool.root" \
--outputRDOFile "g4digi.RDO.pool.root" \
--jobNumber=999999 \
--maxEvents=10

asetup Athena,22.0.41.8,here

Reco_tf.py  --inputRDOFile g4digi.RDO.pool.root \
--outputESDFile esd.pool.root \
--outputAODFile="AOD.pool.root" \
--asetup="RDOtoRDOTrigger:Athena,21.0.54.8" \
--autoConfiguration=everything \
--conditionsTag "default:OFLCOND-MC16-SDR-RUN2-09" "RDOtoRDOTrigger:OFLCOND-MC16-SDR-RUN2-08-02" \
--geometryVersion="default:ATLAS-R2-2016-01-00-01" \
--multithreaded=True \
--postInclude "default:PyJobTransforms/UseFrontier.py" "all:PyJobTransforms/DisableFileSizeLimit.py" \
--preInclude "all:Campaigns/MC20d.py" \
--steering "doOverlay" "doRDO_TRIG" \
--triggerConfig="RDOtoRDOTrigger=MCRECO:DBF:TRIGGERDBMC:2282,107,325" \
--jobNumber=999999
