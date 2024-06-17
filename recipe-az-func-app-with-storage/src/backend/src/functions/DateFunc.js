const { app } = require('@azure/functions');

app.http('DateFunc', {
    methods: ['GET'],
    authLevel: 'anonymous',
    handler: async (request, context) => {
        context.log(`Http function processed request for url "${request.url}"`);
        
        const date = new Date()

        var body = { date: date.toUTCString() };

        return { jsonBody: body };
    }
});
