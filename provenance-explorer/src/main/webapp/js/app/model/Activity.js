Ext.define('CF.model.Activity', {
  extend: 'Ext.data.Model',

  fields: [{
    name: 'ID',
    type: 'string',
    mapping: '@id'
  }, {
    name: 'lastEventTime',
    type: 'string',
    mapping: 's-prov:lastEventTime'
  }
  ,{
    name: 'count',
    type: 'int',
    mapping: 's-prov:count'
  },
   {
    name: 'message',
    type: 'string',
    mapping: 's-prov:message'
  }
  ,
   {
    name: 'worker',
    type: 'string',
    mapping: 's-prov:worker'
  }]
});