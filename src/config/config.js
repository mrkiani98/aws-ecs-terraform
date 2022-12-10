module.exports = {
    aws_table_name: process.env.KIANI_DYNAMODB_TABLE,
    aws_remote_config: {
      // accessKeyId: process.env.AWS_ACCESS_KEY,
      // secretAccessKey: process.env.AWS_SECRET_KEY,
      region: process.env.KIANI_DYNAMODB_REGION,
    }
};