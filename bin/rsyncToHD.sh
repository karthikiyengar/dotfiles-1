#!/bin/bash
rsync -aPvh \
    --info=copy,del,progress2,stats\
    --delete \
    --exclude='.*'\
    /home/murali/ /media/Murali_Transcend/mylap/