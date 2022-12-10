const express = require('express');
const router = express.Router();
let AWS = require('aws-sdk');

let config = require('../config/config');
AWS.config.update(config.aws_remote_config);

let docClient = new AWS.DynamoDB.DocumentClient();
let table = config.aws_table_name;

router.get('/', async (req, res) => {
  let params = {
      TableName: table
  };

  const result = docClient.scan(params);
  const resultItem = await result.promise();
  res.send(resultItem.Items)
});

router.post('/', async (req, res) => {
  let reqBody  = req.body;
  let params = {
    TableName: table,
    Item: {
      id: reqBody.id,
      title: reqBody.title
    }
  };

  const result = docClient.put(params);
  const resuktItem = await result.promise()
  res.send("added successfully!")
});

router.put('/', async (req, res) => {
  let reqBody  = req.body;
  let params = {
        TableName: table,
        Key: { id : reqBody.id },
        UpdateExpression: 'set title = :x',
        ExpressionAttributeValues: {
          ":x": reqBody.title,
        }
  };
  const result = docClient.update(params);
  const resuktItem = await result.promise()
  res.send("updated successfully!")
});

router.delete('/:id', async (req, res) => {
  let reqParam = req.params.id
  let params = {
    TableName: table,
    Key: {
      id: parseInt(reqParam)
    }
  };

  const result = docClient.delete(params);
  const resultItem = await result.promise();
  res.send("delete successfully!")
});

router.get('/:id', async (req, res) => {
  let reqParam = req.params.id
  let params = {
    TableName: table,
    Key: {
      id: parseInt(reqParam)
    }
  };

  const result = docClient.get(params);
  const resultItem = await result.promise();
  res.send(resultItem.Item)
});

module.exports = router; 